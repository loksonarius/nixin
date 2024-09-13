{ config, pkgs, lib, ... }: {
  config = {
    programs.gnupg = {
      agent.enable = true;
      agent.enableSSHSupport = true;
    };
  };
}
