{ modulesPath, lib, pkgs, ... }: {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix") ./disk-config.nix ];
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 6;
    };
    efi.canTouchEfiVariables = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.openssh.enable = true;
  networking.hostName = "freshinstall";

  environment.systemPackages =
    map lib.lowPrio [ pkgs.curl pkgs.gitMinimal pkgs.vim ];

  users.users.root.openssh.authorizedKeys.keys = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMDfCpTdBuZL+7XZgBJeyRF5h8p8+XJQNCeBUEuM79+BAAAACHNzaDpkYW5o"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBhXZmKx3sMF193dr1pdztvXlxEEmQdJ/JZj9X+MGwwnAAAACHNzaDpkYW5o"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFKlU/n+a8NsQ1kMeJOiA5Wqq02XtV19KEBwf6kDTMu5AAAACHNzaDpkYW5o"
    "no-touch-required sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIOM813J5VpjHanGHBZJIcx6pn47y+mZ8dYSwhTiaUb6zAAAABHNzaDo= danh-nt"
  ];

  system.stateVersion = "24.05";
}
