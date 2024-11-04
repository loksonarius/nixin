{ config, lib, pkgs, ... }:
let enabled = config.nixin.users.danh.enable;
in {
  config = lib.mkIf enabled {
    home.packages = [
      pkgs.kubectl

      # plugins and separate tools
      pkgs.k9s
      pkgs.kubectl-ktop
      pkgs.kubectl-neat
      pkgs.kubectx
      pkgs.kubelogin-oidc
      pkgs.kubernetes-helm
      pkgs.stern

      # lol, this lets kubectl pick these binaries as plugins
      (pkgs.writeScriptBin "kubectl-ctx" ''
        #!/usr/bin/env bash
        kubectx $@
      '')
      (pkgs.writeScriptBin "kubectl-ns" ''
        #!/usr/bin/env bash
        kubens $@
      '')
      (pkgs.writeScriptBin "kubectl-stern" ''
        #!/usr/bin/env bash
        stern $@
      '')
    ];
  };
}
