{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.bat = {
      enable = true;
      config.wrap = "never";
    };
  };
}
