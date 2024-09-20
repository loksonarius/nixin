{ config, lib, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    programs.tmux = {
      enable = true;
      escapeTime = 10;
      keyMode = "vi";
      mouse = true;
      terminal = "screen-256color";
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
        "# Soften status bar color"
        "set -g status-bg '#282c34'"
        "set -g status-fg '#848b98'"
        "# Prevent auto-renaming of panes"
        "setw -g automatic-rename off"
        "# Move statusbar to top"
        "set-option -g status-position top"
        "# Center window list"
        "set -g status-justify centre"
        "# Simplify statusbar"
        ''set-window-option -g status-left "->> "''
        ''set-window-option -g status-right " %H:%M %d-%b-%y "''
        "# Big pane-resizing key binds"
        "bind-key -r -T prefix C-Up    resize-pane -U 15"
        "bind-key -r -T prefix C-Down  resize-pane -D 15"
        "bind-key -r -T prefix C-Left  resize-pane -L 15"
        "bind-key -r -T prefix C-Right resize-pane -R 15"
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
