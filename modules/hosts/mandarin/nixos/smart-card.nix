{ config, lib, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in { config = lib.mkIf enabled { services.pcscd.enable = true; }; }
