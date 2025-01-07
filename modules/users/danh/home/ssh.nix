{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "*" = {
          # requires ssh-add -K with smartcard plugged in
          identityFile = "~/.ssh/id_ed25519_sk_rk_danh-nt";
          identitiesOnly = true;
        };
      };
    };
  };
}
