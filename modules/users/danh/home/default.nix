{ config, lib, pkgs, system, ... }:
let
  isDarwin = lib.strings.hasSuffix "darwin" system;
  isLinux = lib.strings.hasSuffix "linux" system;
  homeDir = if isDarwin then
    "/Users/danh"
  else if isLinux then
    "/home/danh"
  else
    "system does not contain a recognized target";
  enabled = config.nixin.users.danh.enable;
in {
  imports = [
    ./../options.nix
    ./ack.nix
    ./age.nix
    ./amethyst.nix
    ./bat.nix
    ./colima.nix
    ./direnv.nix
    ./editorconfig.nix
    ./fish.nix
    ./fonts.nix
    ./gh.nix
    ./git.nix
    ./iterm2
    ./kde
    ./kubectl.nix
    ./lsd.nix
    ./misc-pkgs.nix
    ./nixvim
    ./starship.nix
    ./tmux.nix
  ];

  config = lib.mkIf enabled {
    home.username = "danh";
    home.homeDirectory = homeDir;
    home.stateVersion = "23.05";
    programs.home-manager.enable = true;

    # default-theme programs where possible
    catppuccin.flavor = "mocha";
    catppuccin.enable = true;
  };
}
