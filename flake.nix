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
    let system = "darwin";
    in {
      darwinConfigurations."danh@keylime" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit nixpkgs system; };
        modules = [
          # OS Config
          ./darwin/keylime

          # User Config
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];

            users.users.danh = {
              name = "danh";
              home = "/Users/danh";
            };
            home-manager.users.danh = import ./home { inherit system; };
          }
        ];
      };
    };
}
