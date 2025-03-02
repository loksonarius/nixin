{ config, lib, ... }:
let enabled = config.nixin.hosts.nutmeg.enable;
in { config = lib.mkIf enabled { services.openssh.enable = true; }; }
