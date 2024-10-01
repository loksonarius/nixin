{ config, lib, system, ... }:
let
  cfg = config.nixin.users.danh;
  enabled = cfg.enable && cfg.host == "keylime"
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    homebrew.casks = [
      "anki"
      "blender"
      "discord"
      "godot"
      "itch"
      "obs"
      "protonmail-bridge"
      "steam"
      "vlc"
      "yubico-yubikey-manager"
      "zoom"
    ];

    homebrew.masApps = {
      "DaVinci Resolve" = 571213070;
      "Gifox 2" = 1461845568;
      "Reeder Classic." = 1529448980;
      "WhatsApp Messenger" = 310633997;
    };
  };
}
