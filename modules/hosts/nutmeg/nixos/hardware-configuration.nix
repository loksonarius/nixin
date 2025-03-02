{ config, lib, pkgs, modulesPath, ... }:
let enabled = config.nixin.hosts.nutmeg.enable;
in {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  config = lib.mkIf enabled {
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" ];
    boot.initrd.kernelModules = [ "dm-snapshot" "nfs" ];
    boot.initrd.supportedFilesystems = [ "nfs" ];
    boot.supportedFilesystems = [ "nfs" ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/01f5a4dc-ab13-4f4f-92a4-ee8830a05976";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/A9D2-2725";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    swapDevices = [ ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
