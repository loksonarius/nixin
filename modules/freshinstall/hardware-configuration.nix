# meant to be over-written by nixos-anywhere every time a new host is
# provisioned; copy this file over to a new host's nixos module files after
# provisioning into a freshinstall state
throw ''
  Have you forgotten to run nixos-anywhere with `--generate-hardware-config
  nixos-generate-config ./modules/freshinstall/hardware-configuration.nix`?''
