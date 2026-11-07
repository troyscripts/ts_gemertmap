#!/usr/bin/env python3
"""Static package verification for ts_gemertmap 1.1.0; does not require FiveM."""
from pathlib import Path
import json
import math
import re

root = Path(__file__).resolve().parent.parent
manifest = (root / "fxmanifest.lua").read_text(encoding="utf-8")
version = re.search(r"^version\s+['\"]([^'\"]+)['\"]", manifest, re.M)
assert version and version.group(1) == "1.1.0", "fxmanifest version mismatch"
assert (root / "version.txt").read_text(encoding="utf-8").strip() == version.group(1), "version.txt mismatch"
assert re.search(r"this_is_a_map\s+['\"]yes['\"]", manifest), "map manifest flag missing"
assert "dependency 'ox_lib'" in manifest, "ox_lib dependency missing"

def entries(field):
    table = re.search(r"^" + field + r"\s*\{([^}]+)\}", manifest, re.M | re.S)
    assert table, f"missing manifest list: {field}"
    return re.findall(r"['\"]([^'\"]+)['\"]", table.group(1))

assert entries("shared_scripts") == ["@ox_lib/init.lua", "config/config.lua"], "shared load order changed"
assert entries("client_scripts") == ["client/main.lua", "client/postcodes.lua"], "client load order changed"
assert entries("server_scripts") == ["server/main.lua", "server/update_check.lua"], "server load order changed"
assert entries("files") == ["data/postcodes.json"], "postcode data not registered"
for entry in entries("shared_scripts") + entries("client_scripts") + entries("server_scripts") + entries("files"):
    if entry.startswith("@"):
        continue
    assert (root / entry).is_file(), f"missing manifest file: {entry}"

for old_path in ("client.lua", "postcodes.lua", "server.lua", "update_check.lua",
                 "config.lua", "postcodes.json", "kaartnamen.json", "CHANGELOG.md",
                 "GITHUB.md", "LEESMIJ.md"):
    assert not (root / old_path).exists(), f"old file left at root: {old_path}"

config = (root / "config/config.lua").read_text(encoding="utf-8")
assert re.search(r"Config\.Version\s*=\s*'1\.0\.9'", config), "Config.Version moet bij nieuwe defaults 1.0.9 zijn"
loader = (root / "client/postcodes.lua").read_text(encoding="utf-8")
assert "LoadResourceFile(GetCurrentResourceName(), 'data/postcodes.json')" in loader, "postcode loader path missing"
assert "exports('GetNearestPostcode'" in loader and "exports('GetLocation'" in loader, "location exports altered"
assert "RegisterCommand('postcode'" in loader, "postcode command missing"
assert "RegisterCommand('gemertmapreset'" in (root / "client/main.lua").read_text(encoding="utf-8"), "reset command missing"
assert "(ROOT/'data/kaartnamen.json')" in (root / "tools/build_map.py").read_text(encoding="utf-8"), "map build script data path missing"

postcodes = json.loads((root / "data/postcodes.json").read_text(encoding="utf-8"))
labels = json.loads((root / "data/kaartnamen.json").read_text(encoding="utf-8"))
assert "Config.ZoomRefreshMs = 0" in config, "radar refresh default should be disabled"
assert "Repository = 'troyscripts/ts_gemertmap'" in config, "default GitHub repository missing"
assert "AddEventHandler('playerSpawned'" in (root / "client/main.lua").read_text(), "respawn zoom hook missing"
assert len(postcodes) == 946, f"expected 946 postcodes, got {len(postcodes)}"
assert len(labels) == 46, f"expected 46 map labels, got {len(labels)}"
keys = set()
for postal in postcodes:
    assert isinstance(postal["code"], str) and postal["code"].isdigit()
    normalized = postal["code"].lstrip("0")
    assert normalized not in keys and normalized, f"duplicate or empty normalized postcode: {normalized}"
    keys.add(normalized)
    assert all(isinstance(postal[k], (int, float)) and math.isfinite(postal[k]) for k in ("x", "y"))
for label in labels:
    assert isinstance(label["text"], str) and label["text"]
    assert all(isinstance(label[k], (int, float)) and math.isfinite(label[k]) for k in ("x", "y", "size"))

stream = root / "stream"
assets = sorted(x for x in stream.iterdir() if x.is_file())
assert len(assets) == 78, f"expected 78 stream assets, got {len(assets)}"
assert len([x for x in assets if x.suffix.lower() == ".ytd"]) == 13
assert len([x for x in assets if x.suffix.lower() == ".ydd"]) == 65
assert sum(x.stat().st_size for x in assets) == 65347595, "stream data sizes changed or files missing"
assert (root / "LICENSE-Oulsen.txt").exists(), "original Oulsen license missing"
for p in ("docs/CREDITS.md", "docs/INSTALLATIE.md", "docs/STRUCTUUR.md",
          "docs/CHANGELOG.md", "docs/GITHUB.md", "docs/controle/texture-checks.json"):
    assert (root / p).exists(), f"documentation missing: {p}"
assert len(json.loads((root / "docs/controle/texture-checks.json").read_text(encoding="utf-8"))) == 12
print("PASS: manifest, version, Lua paths, 946 postcodes, 46 labels, 78 map assets and license")
