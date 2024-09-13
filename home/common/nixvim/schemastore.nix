{ config, pkgs, lib, ... }: {
  programs.nixvim.plugins.schemastore = {
    enable = true;
    json.enable = true;
    yaml.enable = true;
  };
}
