{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self, nixvim, home-manager, nix-darwin, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        lib = pkgs.lib;
        isDarwin = lib.strings.hasSuffix "darwin" system;
      in {
        packages.homeConfigurations = {
          "danh@home" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit pkgs system; };
            modules = [
              nixvim.homeManagerModules.nixvim
              ./modules/users/home.nix
              { nixin.users.danh.enable = true; }
            ];
          };

          "danh@work" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit pkgs system; };
            modules = [
              nixvim.homeManagerModules.nixvim
              ./modules/users/home.nix
              {
                nixin.users.danh.enable = true;
                nixin.users.danh.git.global.email = "dan.herrera@lambdal.com";
              }
            ];
          };
        };

        packages.darwinConfigurations = lib.attrsets.optionalAttrs isDarwin {
          "danh@keylime" = nix-darwin.lib.darwinSystem {
            specialArgs = { inherit pkgs system; };
            modules = [
              ./modules/users/darwin.nix
              {
                nixin.users.danh.enable = true;
                nixin.users.danh.host = "keylime";
              }
            ];
          };
          "danh@okra" = nix-darwin.lib.darwinSystem {
            specialArgs = { inherit pkgs system; };
            modules = [
              ./modules/users/darwin.nix
              {
                nixin.users.danh.enable = true;
                nixin.users.danh.host = "okra";
              }
            ];
          };
        };
      });
}
