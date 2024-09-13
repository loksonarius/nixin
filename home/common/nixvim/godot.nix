{ config, pkgs, lib, ... }: {
  config = { programs.nixvim.plugins.godot = { enable = true; }; };
}
