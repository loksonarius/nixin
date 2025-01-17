{ config, lib, pkgs, modulesPath, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  config = lib.mkIf enabled {
    boot.initrd.availableKernelModules =
      [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/dd16e22b-a9fb-4771-8c2d-c6bc3764b795";
      fsType = "ext4";
    };

    boot.initrd.luks.devices."luks-4eb4b646-f6d8-46a0-b81a-f9eb39848fa8".device =
      "/dev/disk/by-uuid/4eb4b646-f6d8-46a0-b81a-f9eb39848fa8";

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/5A28-B00D";
      fsType = "vfat";
    };

    swapDevices =
      [{ device = "/dev/disk/by-uuid/33eaacd6-39b3-4bc0-bbb9-93e2b01cf71d"; }];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp166s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
