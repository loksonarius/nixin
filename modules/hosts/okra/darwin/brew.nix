{ config, lib, system, ... }:
let
  enabled = config.nixin.hosts.okra.enable
    && lib.strings.hasSuffix "darwin" system;
in {
  config = lib.mkIf enabled {
    environment.variables.HOMEBREW_NO_ANALYTICS = "1";

    environment.systemPath = [ "/opt/homebrew/bin/" ];

    homebrew.enable = true;

    homebrew.casks = [
      "1password"
      "1password-cli"
      "amethyst"
      "iterm2"
      "keepingyouawake"
      "slack"
      "yubico-authenticator"
    ];

    homebrew.masApps = {
      "AdGuard for Safari" = 1440147259;
      "Dark Reader for Safari" = 1438243180;
      "Keys for Safari" = 1494642810;
    };
  };
}
