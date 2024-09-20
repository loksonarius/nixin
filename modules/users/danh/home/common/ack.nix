{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    home.packages = [ pkgs.ack ];
    home.file = {
      ".ackrc".text =
        "  # Always sort the files\n  --sort-files\n\n  # Always color, even if piping to another program\n  --color\n\n  # Always use smart-casing\n  --smart-case\n";
    };
  };
}
