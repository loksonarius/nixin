{ config, pkgs, lib, ... }:

{
  options = {
    user-home.darwin.enable = lib.mkOption {
      description =
        "Inlcudes Darwin-specific home-manager configuration when enabled";
      default = false;
      example = true;
      type = lib.types.bool;
    };
  };

  # no gpg-agent config option for home-manager on Darwin
  config = lib.mkIf config.user-home.darwin.enable {
    home.file.".gnupg/gpg-agent.conf".text = ''
      enable-putty-support
      enable-ssh-support
      default-cache-ttl 600
      max-cache-ttl 7200
      pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
    '';

    home.packages = with pkgs; [ gnutar pinentry_mac unixtools.watch ];

    # the godot package provided by nixpkgs does not compile on Darwin
    programs.nixvim.plugins.godot = {
      godotPackage = null;
      settings.executable = "/Applications/Godot.app/Contents/MacOS/Godot";
    };

    home.file.".config/amethyst/amethyst.yml".text = ''
      layouts:
        - middle-wide
        - tall
        - wide
        - fullscreen
        - column
        - bsp

      mod1:
        - option
        - shift

      mod2:
        - option
        - shift
        - control

      select-tall-layout:
        mod: mod1
        key: "1"

      select-wide-layout:
        mod: mod1
        key: "2"

      select-bsp-layout:
        mod: mod1
        key: "3"

      select-fullscreen-layout:
        mod: mod1
        key: "4"

      select-column-layout:
        mod: mod1
        key: f

      mouse-swaps-windows: true
    '';
  };
}
