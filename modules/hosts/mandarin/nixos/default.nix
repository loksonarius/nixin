{ config, lib, pkgs, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in {
  imports = [ ./../options.nix ./hardware-configuration.nix ];

  config = lib.mkIf enabled {
    system.stateVersion = "23.11";
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      initrd.luks.devices."luks-b9512147-44bc-4336-b74d-f551fdb0f624".device =
        "/dev/disk/by-uuid/b9512147-44bc-4336-b74d-f551fdb0f624";
    };

    networking.hostName = "mandarin"; # Define your hostname.
    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    services.xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
      desktopManager.plasma5.enable = true;
    };
    services.displayManager.sddm.enable = true;

    services.printing.enable = true;

    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = [ pkgs.firefox pkgs.git pkgs.vim pkgs.wget ];

    services.pcscd.enable = true;

    users.mutableUsers = false;
  };
}
