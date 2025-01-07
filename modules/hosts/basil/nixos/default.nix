{ ... }: {
  imports = [
    ./../options.nix
    ./hardware-configuration.nix

    ./boot.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./ssh.nix
    ./users.nix
  ];
}
