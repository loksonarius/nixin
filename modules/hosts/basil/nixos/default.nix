{ ... }: {
  imports = [
    ./../options.nix
    ./hardware-configuration.nix

    ./boot.nix
    ./hardware-acceleration.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./services.nix
    ./ssh.nix
    ./storage.nix
    ./users.nix
  ];
}
