{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          end_of_line = "lf";
          insert_final_newline = true;
          trim_trailing_whitespace = true;
        };

        "*.sh" = {
          indent_style = "tab";
          indent_size = 2;
          charset = "utf-8";
        };

        "*.py" = {
          indent_style = "space";
          indent_size = 4;
          charset = "utf-8";
        };

        "*.gd" = {
          indent_style = "tab";
          indent_size = 2;
          charset = "utf-8";
        };

        "{*.rb,Gemfile,Berksfile}" = {
          indent_style = "space";
          indent_size = 2;
        };

        "*.go" = {
          indent_style = "tab";
          indent_size = 2;
        };

        "*.{rs,toml}" = {
          indent_size = 2;
          indent_style = "space";
          insert_final_newline = true;
          trim_trailing_whitespace = true;
        };

        "*.{c,cpp,h}" = {
          indent_style = "tab";
          indent_size = 2;
        };

        "*.{yaml,yml}" = {
          indent_style = "space";
          indent_size = 2;
        };

        "*.tf" = {
          indent_size = 2;
          indent_style = "space";
          trim_trailing_whitespace = true;
        };

        "*.html" = {
          indent_size = 2;
          indent_style = "space";
          trim_trailing_whitespace = true;
        };

        "{JUSTFILE,.justfile,Justfile,justfile}" = {
          indent_size = 2;
          indent_style = "space";
          trim_trailing_whitespace = true;
        };

        "*.nix" = {
          indent_size = 2;
          indent_style = "space";
          trim_trailing_whitespace = true;
        };
      };
    };
  };
}
