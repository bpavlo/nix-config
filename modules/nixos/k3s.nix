{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.k3s;
in
{
  options.modules.nixos.k3s.enable = lib.mkEnableOption "k3s server with kube CLI tooling";
  config = lib.mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = [
        "--write-kubeconfig-mode=0644"
      ];
    };

    systemd.services.k3s.wantedBy = lib.mkForce [ ];

    environment.systemPackages = with pkgs; [
      k3s
      kubectl
      kubernetes-helm
      helmfile
      k9s
      kubectx
      minikube
    ];

    networking.firewall.trustedInterfaces = [ "cni0" ];
  };
}
