{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.nutmeg.enable;
in {
  config = lib.mkIf enabled {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };

    hardware.graphics = {
      enable = true;
      extraPackages = [
        pkgs.vaapiVdpau

        pkgs.intel-media-driver
        pkgs.intel-vaapi-driver
        pkgs.intel-compute-runtime
        # QSV on 11th gen or newer
        # pkgs.vpl-gpu-rt
        # QSV up to 11th gen
        pkgs.intel-media-sdk
      ];
    };
  };
}
