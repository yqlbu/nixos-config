{ pkgs, ... }:

{
  home.packages = with pkgs; [
    btop
    htop
    nvtopPackages.intel # gpu
    bottom # process
    ncdu # disk utilization
    duf # disk usage analyzer
    powertop # power consumption
    tcpdump # Network sniffer
  ];
}
