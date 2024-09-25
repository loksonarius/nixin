{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    home.packages = [ pkgs.git-ignore ];
    programs.gh.enable = true;

    programs.fish.interactiveShellInit = ''
      # Github CLI Completion
      eval (${config.programs.gh.package}/bin/gh completion -s fish)
    '';
  };
}
