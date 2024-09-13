{ config, pkgs, lib, ... }: {
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
}
