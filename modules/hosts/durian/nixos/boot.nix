{ config, lib, ... }:
let enabled = config.nixin.hosts.durian.enable;
in {
  config = lib.mkIf enabled {
    boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 6;
      };
      efi.canTouchEfiVariables = true;
    };
    boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    security.polkit.enable = true;
  };
}
