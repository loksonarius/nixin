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
      darwinConfigurations = {
        "danh@keylime" = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit pkgs system; };
          modules = [
            ./modules/users/danh/darwin
            ./modules/hosts/keylime/darwin
            {
              nixin.users.danh.enable = true;
              nixin.hosts.keylime.enable = true;
            }
          ];
        };
      };

      homeConfigurations = {
        "danh@keylime" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit pkgs system; };
          modules = [
            nixvim.homeManagerModules.nixvim
            ./modules/users/danh/home
            { nixin.users.danh.enable = true; }
          ];
        };
      };
    };
}
