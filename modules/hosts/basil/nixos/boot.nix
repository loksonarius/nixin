{ config, lib, ... }:
let enabled = config.nixin.hosts.basil.enable;
in {
  config = lib.mkIf enabled {
    boot.loader.grub = {
      configurationLimit = 6;
      efiSupport = true;
      efiInstallAsRemovable = true;
    };
  };
}
