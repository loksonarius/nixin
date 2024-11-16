{ ... }: {
  imports = [
    ./../options.nix
    ./hardware-configuration.nix

    ./audio.nix
    ./boot.nix
    ./desktop.nix
    ./display.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./printing.nix
    ./smart-card.nix
    ./users.nix
  ];
}
