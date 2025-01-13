{ lib, ... }: {
  options = {
    nixin.users.danh = {
      enable = lib.mkEnableOption "danh";
      host = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum [
          "basil"
          "nutmeg"
          "keylime"
          "okra"
          "mandarin"
          "durian"
        ]);
        description = ''
          A target host to enable specific configurations for.
        '';
        example = "keylime";
      };

      git.global = {
        email = lib.mkOption {
          type = lib.types.str;
          description = ''
            Git commit author e-mail address to use as global setting.
          '';
          default = "danh@shew.io";
          example = "danh@shew.io";
        };
      };

      extra_pkgs = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        description = ''
          List of misc nix pkgs to install.
        '';
        default = [ ];
        example = "[ pkgs.awscli2 ]";
      };

      extra_groups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = ''
          List of extra groups to add for user.
        '';
        default = [ ];
        example = ''[ "gamemode" ]'';
      };
    };
  };
}
