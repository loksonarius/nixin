{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.tmux = {
      enable = true;
      escapeTime = 10;
      keyMode = "vi";
      mouse = true;
      terminal = "tmux-256color";
      shell = "${pkgs.fish}/bin/fish";
      sensibleOnTop = false;

      plugins = [{
        plugin = pkgs.tmuxPlugins.catppuccin.overrideAttrs (_: {
          src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "a3df709c68601abfee01bf39417d50fb421452d0";
            sha256 = "sha256-4SDbUYTgurXnW7YTzPDqe13scDF3Y+N8Trd3zGeWFwA=";
          };
        });
        extraConfig = lib.concatStringsSep "\n" [
          ''set -g @catppuccin_flavour "macchiato"''
          ''set -g @catppuccin_window_status_style "rounded"''
          ''set -g @catppuccin_status_background "#{@thm_surface_2}"''
        ];
      }];

      extraConfig = lib.concatStringsSep "\n" [
        "# Vim Keybindings"
        "bind -T copy-mode-vi v send -X begin-selection"
        "bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'"

        "# Use current path in new panes"
        ''bind '"' split-window -c "#{pane_current_path}"''
        ''bind % split-window -h -c "#{pane_current_path}"''
        ''bind c new-window -c "#{pane_current_path}"''

        "# Renumber windows on upon closing one"
        "set -g renumber-windows on"

        "# Configure statusbar"
        "set -g status-right-length 100"
        "set -g status-left-length 100"
        ''set -g status-left ""''
        ''set -g status-right "#{E:@catppuccin_status_application}"''
        ''set -agF status-right "#{E:@catppuccin_status_host}"''
        ''set -agF status-right "#{E:@catppuccin_status_date_time}"''
        "set-option -g status-position top"

        "# Big pane-resizing key binds"
        "bind-key -r -T prefix C-Up    resize-pane -U 15"
        "bind-key -r -T prefix C-Down  resize-pane -D 15"
        "bind-key -r -T prefix C-Left  resize-pane -L 15"
        "bind-key -r -T prefix C-Right resize-pane -R 15"

        "# Reload config key bind"
        "bind-key -r -T prefix r source ~/.config/tmux/tmux.conf"

        "# Start windows and panes at 1, not 0"
        "set -g base-index 1"
        "set -g pane-base-index 1"
        "set-window-option -g pane-base-index 1"

        "# Increase window for repeated commands"
        "set -g repeat-time 1000"
      ];
    };

    programs.fish.shellInitLast = ''
      if not set -q TMUX
        set session (${config.programs.tmux.package}/bin/tmux list-sessions 2> /dev/null | sort | head -n1 | cut -d: -f1)
        if test -z $session
          ${config.programs.tmux.package}/bin/tmux new -s 0
        else
          ${config.programs.tmux.package}/bin/tmux attach -t $session
        end
      end
    '';
  };
}
