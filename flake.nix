{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    secrets.url = "git+file:./secrets";
    secrets.inputs.nixpkgs.follows = "nixpkgs";
    # secrets.url =
    #   "git+ssh://git@github.com/loksonarius/nixin-secrets.git?ref=main&shallow=1";
  };

  outputs = inputs@{ self, nixos-hardware, nix-darwin, nixvim, home-manager
    , agenix, secrets, flake-utils, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        lib = pkgs.lib;
        isDarwin = lib.strings.hasSuffix "darwin" system;
        isLinux = lib.strings.hasSuffix "linux" system;
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
                nixin.users.danh.extra_pkgs = [ pkgs.awscli2 ];
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

        packages.nixosConfigurations = lib.attrsets.optionalAttrs isLinux {
          "mandarin" = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              agenix.nixosModules.default
              secrets.nixosModules.default
              nixos-hardware.nixosModules.framework-12th-gen-intel
              ./modules/users/nixos.nix
              ./modules/hosts/nixos.nix
              {
                secrets.host = "mandarin";
                nixin.users.danh.enable = true;
                nixin.users.danh.host = "mandarin";
                nixin.hosts.mandarin.enable = true;
              }
            ];
          };
        };
      });
}
