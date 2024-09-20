{ config, lib, pkgs, system, ... }:
let
  enabled = config.nixin.hosts.keylime.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    nix.gc.automatic = true;
    nix.optimise.automatic = true;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.pkgs = pkgs;

    services.nix-daemon.enable = true;
  };
}
