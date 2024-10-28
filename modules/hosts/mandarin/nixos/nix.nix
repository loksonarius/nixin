{ config, lib, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  config = lib.mkIf enabled {
    system.stateVersion = "23.11";
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
