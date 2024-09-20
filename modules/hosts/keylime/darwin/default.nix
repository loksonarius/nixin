{ config, lib, system, ... }: {
  imports = [
    ./../options.nix
    ./brew.nix
    ./gnupg.nix
    ./nix.nix
    ./preferences.nix
    ./system.nix
  ];
}
