{ config, pkgs, lib, ... }: {
  imports = [
    ./ack.nix
    ./bat.nix
    ./direnv.nix
    ./fish.nix
    ./fonts.nix
    ./git.nix
    ./gpg.nix
    ./kubectl.nix
    ./lsd.nix
    ./nixvim
    ./starship.nix
    ./tmux.nix
  ];
  config = {
    # TODO(danh): these needed?
    # home.sessionVariables = { EDITOR = "nvim"; };
    # xdg.enable = true;
    home.packages = with pkgs; [ fd jq teleport wget ];
  };
}
