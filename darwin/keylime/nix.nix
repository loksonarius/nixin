{ config, pkgs, lib, ... }: {
  config = {
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
