{ ... }: {
  system.stateVersion = 4;
  # enable for the default system shell so we have nix available for use there
  programs.zsh.enable = true;
  programs.fish.enable = true;
}
