{ config, lib, ... }:
let enabled = config.nixin.hosts.durian.enable;
in { config = lib.mkIf enabled { users.mutableUsers = false; }; }
