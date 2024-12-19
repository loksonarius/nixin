{ lib, ... }: {
  options = {
    nixin.hosts.durian = {
      enable = lib.mkEnableOption "durian";

      extra_pkgs = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        description = ''
          List of misc nix pkgs to install as system packages.
        '';
        default = [ ];
        example = "[ pkgs.bottles ]";
      };
    };
  };
}
