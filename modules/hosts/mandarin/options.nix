{ lib, ... }: {
  options = {
    nixin.hosts.mandarin = {
      enable = lib.mkEnableOption "mandarin";
    };
  };
}
