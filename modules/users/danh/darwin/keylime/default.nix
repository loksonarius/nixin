{ config, lib, system, ... }: {
  imports = [ ./brew.nix ./gnupg.nix ./preferences.nix ];
}
