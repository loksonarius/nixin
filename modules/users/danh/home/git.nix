{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    home.packages = [ pkgs.git-ignore ];
    programs.git = {
      enable = true;
      userName = "Dan Herrera";
      userEmail = "danh@shew.io";

      delta = {
        enable = true;
        options = {
          syntax-theme = "OneHalfDark";
          side-by-side = true;
        };
      };
      lfs.enable = true;

      extraConfig = {
        gpg.format = "ssh";
        tag.gpgsign = true;
        user.signingKey = "~/.ssh/id_ed25519_sk_rk_danh-pk.pub";
      };

      ignores = [
        ".DS_Store"
        ".direnv"
        ".envrc"
        ".shell.nix"
        ".swp"
        ".tool-versions"
        ".venv"
        "tags"
      ];

      extraConfig = {
        core.editor = "nvim";
        init.defaultBranch = "main";
      };
    };

    programs.ssh = {
      enable = true;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          # requires ssh-add -K with smartcard plugged in
          identityFile = "~/.ssh/id_ed25519_sk_rk_danh";
          identitiesOnly = true;
        };
      };
    };

    home.shellAliases = {
      g = "git";

      gs = "git status";
      gd = "git diff";
      ga = "git add";
      gap = "git add -p";
      gc = "git commit";
      gca = "git commit --amend";
      gcm = "git commit -m";

      glo = "git log";
      glos = "git log --show-signature";
      gt = "git tag";
      gtd = "git tag -d";

      gco = "git checkout";
      gcb = "git checkout -b";
      gb = "git branch";

      gl = "git pull";
      gp = "git push";
      gpf = "git push -f";
      gpu = "git push -u origin HEAD";

      gi = "git ignore";
      gcl = "git clone";
    };
  };
}
