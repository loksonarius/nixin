{
  description = "Kitchen sink of outputs used by nix ecosystem tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Handy-dandy flake functions
    flake-utils.url = "github:numtide/flake-utils";

    # Manage user dotfiles, configs, packages, and services
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nixified config for neovim
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Shotgun blast catppuccin everywhere
    catppuccin.url = "github:catppuccin/nix";

    # Configure system preferences and manage brew
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Used to pull-in pre-made configs for laptops and some hardware combos
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Configure disks and partitions for installs
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Storing secrets in a whole other place
    secrets.url = "git+ssh://git@github.com/loksonarius/nixin-secrets.git";
    secrets.inputs.nixpkgs.follows = "nixpkgs";

    # Inject secrets as files in nixOS configs
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, nixvim
    , catppuccin, nix-darwin, nixos-hardware, disko, secrets, agenix, }:
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
              catppuccin.homeManagerModules.catppuccin
              nixvim.homeManagerModules.nixvim
              ./modules/users/home.nix
              { nixin.users.danh.enable = true; }
            ];
          };

          "danh@work" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = { inherit pkgs system; };
            modules = [
              catppuccin.homeManagerModules.catppuccin
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
              catppuccin.nixosModules.catppuccin
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

          "durian" = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              agenix.nixosModules.default
              secrets.nixosModules.default
              catppuccin.nixosModules.catppuccin
              ./modules/users/nixos.nix
              ./modules/hosts/nixos.nix
              {
                secrets.host = "durian";
                nixin.users.danh.enable = true;
                nixin.users.danh.host = "durian";
                nixin.users.danh.extra_groups = [ "gamemode" ];
                nixin.hosts.durian.enable = true;
                nixin.hosts.durian.extra_pkgs = [
                  pkgs.bottles
                  pkgs.kdePackages.krdc
                  pkgs.obs-studio
                  pkgs.ffmpeg
                  pkgs.solaar
                ];
                hardware.logitech.wireless.enable = true;
              }
            ];
          };

          "freshinstall" = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              disko.nixosModules.disko
              ./modules/freshinstall/configuration.nix
              ./modules/freshinstall/hardware-configuration.nix
            ];
          };
        };
      });
}
