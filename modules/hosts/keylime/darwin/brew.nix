{ config, lib, system, ... }:
let
  enabled = config.nixin.hosts.keylime.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    environment.variables.HOMEBREW_NO_ANALYTICS = "1";

    environment.systemPath = [ "/opt/homebrew/bin/" ];

    homebrew.enable = true;

    homebrew.casks = [
      "1password"
      "1password-cli"
      "aerial"
      "anki"
      "amethyst"
      "blender"
      "discord"
      "godot"
      "itch"
      "iterm2"
      "keepingyouawake"
      "obs"
      "protonmail-bridge"
      "steam"
      "vlc"
      "yubico-authenticator"
      "yubico-yubikey-manager"
      "zoom"
    ];

    homebrew.masApps = {
      "AdGuard for Safari" = 1440147259;
      "DaVinci Resolve" = 571213070;
      "Dark Reader for Safari" = 1438243180;
      "Gifox 2" = 1461845568;
      "Keys for Safari" = 1494642810;
      "Reeder Classic." = 1529448980;
      "WhatsApp Messenger" = 310633997;
    };
  };
}
