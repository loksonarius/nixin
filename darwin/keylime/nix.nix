{ config, pkgs, lib, ... }: {
  config = {
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };

    nix.gc.automatic = true;
    nix.optimise.automatic = true;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.hostPlatform = "aarch64-darwin";

    services.nix-daemon.enable = true;
  };
}
