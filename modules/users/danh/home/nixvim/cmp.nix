{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.nixvim.plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';

        sources = [
          { name = "cmp-path"; }
          { name = "luasnip"; }
          { name = "nvim-lua"; }
          { name = "nvim_lsp"; }
        ];

        mapping = {
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = ''
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }
          '';
          "<Tab>" = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif require('luasnip').expand_or_jumpable() then
                require('luasnip').expand_or_jump()
              else
                fallback()
              end
            end
          '';
          "<S-Tab>" = ''
            function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif require('luasnip').jumpable(-1) then
                require('luasnip').jump(-1)
              else
                fallback()
              end
            end
          '';
        };
      };
    };
  };
}
