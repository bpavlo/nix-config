{ lib, pkgs, ... }:

{
  services.k3s = {
    enable = true;
    role = "server";
    extraFlags = [
      "--write-kubeconfig-mode=0644"
    ];
  };

  # Manual start: do not auto-start at boot. Use `systemctl start k3s` when needed.
  systemd.services.k3s.wantedBy = lib.mkForce [ ];

  environment.systemPackages = with pkgs; [
    k3s
    kubectl
    kubernetes-helm
    helmfile
    k9s
    kubectx
  ];

  # Allow pod/service traffic on the k3s CNI bridge without poking holes
  # in the external firewall. Tailscale remains the access path.
  networking.firewall.trustedInterfaces = [ "cni0" ];
}
