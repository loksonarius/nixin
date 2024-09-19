# NOT A MODULE
args@{ lib, ... }:
let
  files = [ ./brew.nix ./gnupg.nix ./nix.nix ./preferences.nix ];
  configs = map (file: import file args) files;
  mergedConfig = lib.attrsets.mergeAttrsList configs;
in mergedConfig
