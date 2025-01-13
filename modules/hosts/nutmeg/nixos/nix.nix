{ config, lib, ... }:
let enabled = config.nixin.hosts.nutmeg.enable;
in {
  config = lib.mkIf enabled {
    system.stateVersion = "25.05";
    nixpkgs.config.allowUnfree = true;

    nix = {
      gc.automatic = true;
      gc.dates = "weekly";
      optimise.automatic = true;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
