{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    home.packages = [
      pkgs.k9s
      pkgs.kubectl
      pkgs.kubectl-ktop
      pkgs.kubectl-neat
      pkgs.kubectx
      # lol, this lets kubectl pick kubectx and kubens as plugins
      (pkgs.writeScriptBin "kubectl-ctx" ''
        kubectx $@
      '')
      (pkgs.writeScriptBin "kubectl-ns" ''
        kubens $@
      '')
      pkgs.kubernetes-helm
    ];
  };
}
