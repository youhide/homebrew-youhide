#!/usr/bin/env python3
"""Regenerate Formula/*.rb and README.md from the latest release of each project.

Projects are listed in projects.toml. Releases are public, so this needs no
token beyond the workflow's own: GITHUB_TOKEN, when set, only raises the API
rate limit.

Checksums come from the release's own checksums.txt or <asset>.sha256 files
when it publishes them, and from downloading the asset when it does not.

Usage: scripts/update.py [--message-file PATH]

With --message-file, writes a commit message naming every formula whose
version changed ("hidepass 0.2.1, oxinit 0.2.0"), or "Update formulas" when
only something else did. Exits non-zero if any project failed, after writing
every project that did not.
"""

import hashlib
import json
import os
import pathlib
import re
import sys
import tomllib
import urllib.request

ROOT = pathlib.Path(__file__).resolve().parent.parent
API = "https://api.github.com"
TAP = "youhide/tap"

# GoReleaser's default archive names.
GORELEASER = {
    "darwin_arm": "{prefix}_Darwin_arm64.tar.gz",
    "darwin_intel": "{prefix}_Darwin_x86_64.tar.gz",
    "linux_arm": "{prefix}_Linux_arm64.tar.gz",
    "linux_intel": "{prefix}_Linux_x86_64.tar.gz",
}


def fetch(url: str) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": TAP})
    # The token goes to the API host only. Asset downloads redirect to a CDN,
    # and urllib carries headers across redirects.
    token = os.environ.get("GITHUB_TOKEN")
    if token and url.startswith(API):
        req.add_header("Authorization", f"Bearer {token}")
        req.add_header("Accept", "application/vnd.github+json")
    with urllib.request.urlopen(req, timeout=60) as resp:
        return resp.read()


def latest_release(repo: str, prereleases: bool) -> dict:
    if not prereleases:
        return json.loads(fetch(f"{API}/repos/{repo}/releases/latest"))
    for release in json.loads(fetch(f"{API}/repos/{repo}/releases?per_page=20")):
        if not release["draft"]:
            return release
    raise RuntimeError(f"{repo} has no published release")


def published_checksums(release: dict) -> dict[str, str]:
    sums = {}
    for asset in release["assets"]:
        name = asset["name"]
        if name == "checksums.txt" or name.endswith(".sha256"):
            for line in fetch(asset["browser_download_url"]).decode().splitlines():
                parts = line.split()
                if len(parts) == 2:
                    sums[parts[1].lstrip("*")] = parts[0]
    return sums


def asset_names(project: dict, tag: str) -> dict[str, str]:
    if "goreleaser" in project:
        names = {k: v.format(prefix=project["goreleaser"]) for k, v in GORELEASER.items()}
    else:
        names = dict(project["assets"])
    version = tag.removeprefix("v")
    return {k: v.format(tag=tag, version=version) for k, v in names.items()}


def class_name(formula: str) -> str:
    return "".join(w[:1].upper() + w[1:] for w in re.split(r"[-_]", formula))


def render(name: str, project: dict, release: dict) -> str:
    repo = project["repo"]
    tag = release["tag_name"]
    names = asset_names(project, tag)
    assets = {a["name"]: a["browser_download_url"] for a in release["assets"]}
    sums = published_checksums(release)

    def source(key: str, indent: str) -> str:
        asset = names[key]
        if asset not in assets:
            raise RuntimeError(f"{repo} {tag} has no asset {asset}")
        sha = sums.get(asset) or hashlib.sha256(fetch(assets[asset])).hexdigest()
        return (
            f'{indent}url "https://github.com/{repo}/releases/download/{tag}/{asset}"\n'
            f'{indent}sha256 "{sha}"\n'
        )

    def arches(os_name: str, indent: str) -> str:
        out = ""
        for arch in ("arm", "intel"):
            key = f"{os_name}_{arch}"
            if key in names:
                out += f"{indent}on_{arch} do\n{source(key, indent + '  ')}{indent}end\n"
        return out

    license_ = project["license"]
    if isinstance(license_, list):
        license_line = "license any_of: [" + ", ".join(f'"{l}"' for l in license_) + "]"
    else:
        license_line = f'license "{license_}"'

    has_darwin = any(k.startswith("darwin_") for k in names)
    if has_darwin:
        platforms = (
            f"  on_macos do\n{arches('darwin', '    ')}  end\n\n"
            f"  on_linux do\n{arches('linux', '    ')}  end\n"
        )
    else:
        platforms = f"  depends_on :linux\n\n{arches('linux', '  ')}"

    binaries = project["binaries"]
    install = "    bin.install " + ", ".join(f'"{b}"' for b in binaries) + "\n"
    for doc in project.get("docs", []):
        install += f'    doc.install "{doc}"\n'
    if "completions" in project:
        install += (
            f'    generate_completions_from_executable(bin/"{binaries[0]}", '
            f'"{project["completions"]}")\n'
        )

    test = "".join(f'    system "#{{bin}}/{b}", "--version"\n' for b in binaries)

    return (
        f"class {class_name(name)} < Formula\n"
        f'  desc "{project["desc"]}"\n'
        f'  homepage "https://github.com/{repo}"\n'
        f'  version "{tag.removeprefix("v")}"\n'
        f"  {license_line}\n"
        f"\n"
        f"{platforms}"
        f"\n"
        f"  def install\n{install}  end\n"
        f"\n"
        f"  test do\n{test}  end\n"
        f"end\n"
    )


def readme(projects: dict) -> str:
    lines = [
        "# homebrew-tap",
        "",
        "🍺 homebrew tap for my dark tools. May the brew be with you, hmmmm.",
        "",
        "```bash",
        f"brew install {TAP}/<formula>",
        "```",
        "",
        "## Available Formulas",
        "",
    ]
    for name, project in sorted(projects.items()):
        linux_only = "" if any(
            k.startswith("darwin_") for k in asset_names(project, "v0")
        ) else " *(Linux only)*"
        lines.append(f"- **{name}**: {project['desc']}{linux_only}")
    lines += [
        "",
        "Formulas are regenerated from each project's latest GitHub release by",
        "[`scripts/update.py`](scripts/update.py), hourly and on every change to",
        "[`projects.toml`](projects.toml). Do not edit `Formula/` by hand.",
        "",
    ]
    return "\n".join(lines)


def version_of(text: str) -> str | None:
    match = re.search(r'^  version "([^"]+)"', text, re.MULTILINE)
    return match.group(1) if match else None


def main() -> int:
    message_file = None
    if sys.argv[1:2] == ["--message-file"] and len(sys.argv) == 3:
        message_file = pathlib.Path(sys.argv[2])
    elif len(sys.argv) > 1:
        print(__doc__, file=sys.stderr)
        return 2

    projects = tomllib.loads((ROOT / "projects.toml").read_text())
    (ROOT / "Formula").mkdir(exist_ok=True)

    failed = []
    bumped = []
    for name, project in sorted(projects.items()):
        path = ROOT / "Formula" / f"{name}.rb"
        try:
            release = latest_release(project["repo"], project.get("prereleases", False))
            formula = render(name, project, release)
        except Exception as err:  # one broken project must not hold back the rest
            print(f"::error::{name}: {err}", file=sys.stderr)
            failed.append(name)
            continue

        old = path.read_text() if path.exists() else ""
        if formula != old:
            path.write_text(formula)
            if version_of(formula) != version_of(old):
                bumped.append(f"{name} {version_of(formula)}")
            print(f"{name}: updated to {release['tag_name']}")
        else:
            print(f"{name}: {release['tag_name']}, unchanged")

    (ROOT / "README.md").write_text(readme(projects))

    if message_file:
        message_file.write_text(", ".join(bumped) or "Update formulas")

    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
