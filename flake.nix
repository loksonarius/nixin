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
        specialArgs = { inherit nixpkgs system; };
        modules = [
          ./darwin/keylime
          ./modules
          {
            nixin.darwin = true;
            nixin.users.danh.enable = true;
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
