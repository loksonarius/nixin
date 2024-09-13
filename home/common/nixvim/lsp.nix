{ config, pkgs, lib, ... }: {
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      ansiblels.enable = true;
      clangd.enable = true;
      dockerls.enable = true;
      gdscript.enable = true;
      gopls.enable = true;
      jsonls.enable = true;
      lua-ls.enable = true;
      pylsp.enable = true;
      rust-analyzer = {
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
}
