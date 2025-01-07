{ config, lib, ... }:
let enabled = config.nixin.hosts.basil.enable;
in {
  config = lib.mkIf enabled {
    users.mutableUsers = false;

    # fetched from https://github.com/loksonarius.keys
    users.users.root.openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIMDfCpTdBuZL+7XZgBJeyRF5h8p8+XJQNCeBUEuM79+BAAAACHNzaDpkYW5o"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBhXZmKx3sMF193dr1pdztvXlxEEmQdJ/JZj9X+MGwwnAAAACHNzaDpkYW5o"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIFKlU/n+a8NsQ1kMeJOiA5Wqq02XtV19KEBwf6kDTMu5AAAACHNzaDpkYW5o"
    ];
  };
}
