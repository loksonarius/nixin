{ config, pkgs, lib, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Starship Prompt
      # eval (starship init fish)

      # Enable direnv
      # eval (direnv hook fish)

      # Github CLI Completion
      eval (gh completion -s fish)

      # Leverage gpg for ssh and signing
      set -x GPG_TTY (tty)
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

      tmux new-session -A 0
    '';

    shellAliases = {
      # TODO(danh): do I need this anymore now that I've
      # switched to a GUI pin-entry?
      # gpgre = "gpg-connect-agent updatestartuptty /bye";
    };
  };
}
