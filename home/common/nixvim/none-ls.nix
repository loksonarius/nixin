{ config, pkgs, lib, ... }: {
  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    sources = {
      formatting = {
        clang_format.enable = true;
        fish_indent.enable = true;
        gdformat.enable = true;
        gofmt.enable = true;
        goimports.enable = true;
        just.enable = true;
        markdownlint.enable = true;
        nixfmt.enable = true;
        protolint.enable = true;
        rufo.enable = true;
        shfmt.enable = true;
        terraform_fmt.enable = true;
      };
    };
  };
}
