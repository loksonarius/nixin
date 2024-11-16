{ config, lib, ... }:
let enabled = config.nixin.hosts.mandarin.enable;
in { config = lib.mkIf enabled { users.mutableUsers = false; }; }
