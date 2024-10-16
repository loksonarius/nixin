{ config, lib, system, ... }:
let
  enabled = config.nixin.users.danh.enable;
  isDarwin = lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    programs.nixvim.plugins.lsp = {
      enable = true;

      servers = {
        ansiblels.enable = true;
        clangd.enable = true;
        dockerls.enable = true;
        # the godot package provided by nixpkgs does not compile on Darwin
        gdscript.enable = false;
        gopls.enable = true;
        jsonls.enable = true;
        lua_ls.enable = true;
        pylsp.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        solargraph.enable = true;
        texlab.enable = true;
        yamlls.enable = true;
      };

      keymaps = {
        silent = true;
        lspBuf = {
          "<leader><space>" = "hover";
          "gD" = "declaration";
          "gd" = "definition";
          "gi" = "implementation";

          "<leader>cD" = "declaration";
          "<leader>cd" = "definition";
          "<leader>ci" = "implementation";
          "<leader>cR" = "rename";
          "<leader>cf" = "format";
          "<leader>ca" = "code_action";
        };
        extra = [{
          action = { __raw = "require('telescope.builtin').lsp_references"; };
          key = "<leader>cr";
          mode = "n";
          options.silent = true;
        }];
      };
    };
  };
}
