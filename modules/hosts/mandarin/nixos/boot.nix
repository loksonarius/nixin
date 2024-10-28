{ config, lib, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  config = lib.mkIf enabled {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    boot.initrd.luks.devices."luks-b9512147-44bc-4336-b74d-f551fdb0f624".device =
      "/dev/disk/by-uuid/b9512147-44bc-4336-b74d-f551fdb0f624";
  };
}
