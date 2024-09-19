{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixvim, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    in {
      darwinConfigurations."danh@keylime" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit pkgs; };
        modules = [
          # ./darwin/keylime
          {
            # nix.settings = {
            #   auto-optimise-store = true;
            #   experimental-features = [ "nix-command" "flakes" ];
            # };
            #
            # nix.gc.automatic = true;
            # nix.optimise.automatic = true;
            #
            # nixpkgs.config.allowUnfree = true;
            # nixpkgs.hostPlatform = "aarch64-darwin";
            # nixpkgs.pkgs = pkgs;

            # services.nix-daemon.enable = true;
          }
          ./modules
          {
            nixin.darwin = true;
            nixin.users.danh.enable = true;
            nixin.hosts.keylime.enable = true;
          }
        ];
      };

      homeConfigurations = {
        "danh@keylime" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            nixvim.homeManagerModules.nixvim
            (import ./home { inherit system; })
          ];
        };
      };
    };
}
