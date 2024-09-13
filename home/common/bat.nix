{ config, pkgs, lib, ... }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "OneHalfDark";
      wrap = "never";
    };
  };
}
