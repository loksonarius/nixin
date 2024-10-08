{ lib, ... }: {
  options = {
    nixin.users.danh = {
      enable = lib.mkEnableOption "danh";
      host = lib.mkOption {
        type = lib.types.nullOr (lib.types.enum [ "keylime" "okra" ]);
        description = ''
          A target host to enable specific Darwin configuration for.
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
    };
  };
}
