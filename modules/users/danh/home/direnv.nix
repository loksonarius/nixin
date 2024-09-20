{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
