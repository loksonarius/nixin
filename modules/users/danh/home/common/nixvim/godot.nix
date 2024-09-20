{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config =
    lib.mkIf enabled { programs.nixvim.plugins.godot = { enable = true; }; };
}
