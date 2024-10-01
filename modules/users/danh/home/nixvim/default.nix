{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  imports = [
    ./cmp.nix
    ./gitsigns.nix
    ./godot.nix
    ./lsp.nix
    ./lualine.nix
    ./none-ls.nix
    ./schemastore.nix
    ./telescope.nix
    ./treesitter.nix
  ];
  config = lib.mkIf enabled {
    programs.fish.shellAliases = { vim = "nvim"; };

    programs.nixvim = {
      enable = true;
      editorconfig.enable = true;
      clipboard.register = "unnamedplus";
      colorschemes.onedark.enable = true;
    };

    programs.nixvim.plugins = {
      comment.enable = true;
      fugitive.enable = true;
      indent-blankline.enable = true;
      lsp-format.enable = true;
      luasnip.enable = true;
      markview.enable = true;
      nvim-lightbulb.enable = true;
      rainbow-delimiters.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };

    programs.nixvim.opts = {
      # Set highlight on search
      hlsearch = false;
      # Enable mouse mode
      mouse = "a";
      # Enable break indent
      breakindent = true;
      # Save undo history
      undofile = true;
      # Case insensitive searching UNLESS /C or capital in search
      ignorecase = true;
      smartcase = true;
      # Decrease update time
      updatetime = 250;

      # Disable wrapping
      wrap = false;

      # Show 80 char line
      textwidth = 80;
      colorcolumn = "+1";

      # Enable line folding
      foldmethod = "syntax";
      foldnestmax = 10;
      foldenable = false;
      foldlevel = 1;

      # Make line numbers default and relative
      number = true;
      relativenumber = true;

      # Set completeopt to have a better completion experience
      completeopt = "menuone,noselect";

      # Enable 24-bit colors
      termguicolors = true;
    };

    programs.nixvim.globals = {
      # Remap leader key to Space
      mapleader = " ";
      maplocalleader = " ";

      # Configure blankline
      indent_blankline_char = "┊";
      indent_blankline_filetype_exclude = "{ 'help', 'packer' }";
      indent_blankline_buftype_exclude = "{ 'terminal', 'nofile' }";
      indent_blankline_show_trailing_blankline_indent = false;

      # Use native-terminal background
      onedark_transparent_background = true;
    };

    programs.nixvim.keymaps = [
      # Do nothing if just pressing leader key
      {
        action = "<Nop>";
        key = "<Space>";
        options = {
          noremap = true;
          silent = true;
        };
      }

      # Handle word wrapping when moving across lines
      {
        action = "v:count == 0 ? 'gk' : 'k'";
        key = "k";
        options = {
          noremap = true;
          expr = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "v:count == 0 ? 'gj' : 'j'";
        key = "j";
        options = {
          noremap = true;
          expr = true;
          silent = true;
        };
        mode = "n";
      }

      # Editor shortcuts
      {
        action = "<cmd>w<CR>";
        key = "<leader>w";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>q<CR>";
        key = "<leader>q";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>Ex<CR>";
        key = "<leader>e";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }

      # Searching
      {
        action =
          "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>";
        key = "<leader>f";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua require('telescope.builtin').buffers()<CR>";
        key = "<leader>fb";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua require('telescope.builtin').find_files()<CR>";
        key = "<leader>ff";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua require('telescope.builtin').help_tags()<CR>";
        key = "<leader>fh";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua require('telescope.builtin').tags()<CR>";
        key = "<leader>ft";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua require('telescope.builtin').live_grep()<CR>";
        key = "<leader>fg";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }

      # Diagnostics
      {
        action = "<cmd>lua require('telescope.builtin').diagnostics()<CR>";
        key = "<leader>dl";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        key = "<leader>d";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua vim.diagnostic.hide()<CR>";
        key = "<leader>dh";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua vim.diagnostic.show()<CR>";
        key = "<leader>ds";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        key = "[d";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        key = "]d";
        options = {
          noremap = true;
          silent = true;
        };
        mode = "n";
      }
    ];
  };
}
