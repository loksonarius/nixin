{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.nutmeg.enable;
in {
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

      pkgs.nvidia-vaapi-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;

    nvidiaSettings = true;
    nvidiaPersistenced = true;
  };

  hardware.nvidia-container-toolkit.enable = true;
}
