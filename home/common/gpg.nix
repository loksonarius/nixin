{ config, pkgs, lib, ... }: {
  programs.gpg = {
    enable = true;
    settings = { charset = "utf-8"; };
  };

  # not every target OS can use home-manager's gpg-agent service option,
  # so I add this little portion here that's cross-platform enough
  home.packages = [ pkgs.pinentry-tty ];
  home.file.".gnupg/gpg-agent.conf".text = ''
    enable-putty-support
    enable-ssh-support
    default-cache-ttl 600
    max-cache-ttl 7200
    pinentry-program ${pkgs.pinentry-tty}/bin/pinentry-tty
  '';

}
