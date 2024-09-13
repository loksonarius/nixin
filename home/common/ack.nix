{ config, pkgs, lib, ... }: {
  home.packages = [ pkgs.ack ];
  home.file = {
    ".ackrc".text = ''
      # Always sort the files
      --sort-files

      # Always color, even if piping to another program
      --color

      # Always use smart-casing
      --smart-case
    '';
  };
}
