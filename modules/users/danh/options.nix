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
    };
  };
}
