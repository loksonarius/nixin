{ config, lib, system, pkgs, ... }:
let
  enabled = config.nixin.users.danh.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    home.packages = [ pkgs.colima pkgs.docker-client ];
    home.file.".colima/_templates/default.yaml".text = ''
      cpu: 4
      disk: 60
      memory: 8
      runtime: docker
      kubernetes:
        enabled: true
        version: v1.30.2+k3s1
        k3sArgs:
          - --disable=traefik
      vmType: qemu
    '';

    home.shellAliases = { nerdctl = "colima nerdctl"; };
  };
}
