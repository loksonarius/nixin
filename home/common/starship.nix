{ config, pkgs, lib, ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      ###############
      # Prompt-Wide #
      ###############
      add_newline = true;

      format = lib.concatStrings [
        "$time($cmd_duration)$line_break"

        "$package"
        "$dotnet"
        "$golang"
        "$java"
        "$nodejs"
        "$python"
        "$ruby"
        "$rust"

        "$kubernetes"

        "$git_branch"
        "$line_break"

        "$directory"
        "$character"
      ];

      #############
      # Debugging #
      #############
      cmd_duration.format = " [\\( $duration\\)]($style)";
      cmd_duration.min_time = 10000;
      cmd_duration.style = "bold";

      time.format = "[ $time]($style)";
      time.style = "bold";
      time.disabled = false;

      ##############
      # Formatting #
      ##############
      line_break.disabled = false;

      #############
      # Languages #
      #############
      package.format = "[\\[$symbol $version\\]]($style)";
      package.style = "black bold dimmed";
      package.symbol = "";

      dotnet.format = "[\\[$symbol $version\\]]($style)";
      dotnet.style = "cyan dimmed";
      dotnet.symbol = "";

      golang.format = "[\\[$symbol $version\\]]($style)";
      golang.style = "blue dimmed";
      golang.symbol = "󰟓";

      java.format = "[\\[$symbol $version\\]]($style)";
      java.style = "yellow dimmed";
      java.symbol = "";

      nodejs.format = "[\\[$symbol $version\\]]($style)";
      nodejs.style = "green dimmed";
      nodejs.symbol = "";

      python.format = "[\\[$symbol $version\\]]($style)";
      python.style = "yellow dimmed";
      python.symbol = "";

      ruby.format = "[\\[$symbol $version\\]]($style)";
      ruby.style = "red dimmed";
      ruby.symbol = "";

      rust.format = "[\\[$symbol $version\\]]($style)";
      rust.style = "red dimmed";
      rust.symbol = "";

      ###########
      # Context #
      ###########
      kubernetes.disabled = false;
      kubernetes.format = "[\\($symbol $context(|$namespace)\\)]($style)";
      kubernetes.style = "cyan dimmed";
      kubernetes.symbol = "☸";

      git_branch.format = "[\\($symbol $branch\\)]($style)";
      git_branch.symbol = "";

      directory.format = "[ $path]($style)([$read_only]($read_only_style)) ";
      directory.style = "bold";
    };
  };
}
