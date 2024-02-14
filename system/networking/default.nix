{ inputs, system, pkgs, ... }:

{
  networking = {
    networkmanager.enable = true;
    firewall = {
      # Open ports in the firewall
      allowedTCPPorts = [ 22 ];
      # allowedUDPPorts = [ ... ];
      # enable = false; # disable the firewall
    };
    # Configure network proxy if necessary
    # proxy = {
    #   default = "http://user:password@proxy:port/";
    #   noProxy = "127.0.0.1,localhost,internal.domain";
    # };
  };

  environment.systemPackages = with pkgs; [
    inputs.daeuniverse.packages.${system}.dae
    tailscale
  ];

  services = {
    # enable tailscaled
    tailscale.enable = true;
  };
}
