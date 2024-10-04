{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.direnv = {
      enable = true;
      config.global = {
        disable_stdin = false;
        warn_timeout = "30s";
      };
      nix-direnv.enable = true;
    };
  };
}
