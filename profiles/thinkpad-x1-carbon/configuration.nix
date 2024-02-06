{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system
    ../../themes
    ../../home/environment.nix
    ../../home/users.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.enableAllFirmware = true;

  # Set hostname
  networking.hostName = "nixos-x1-carbon";

  # Select internationalisation properties
  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-material-color
    ];
  };

  # Enable CUPS to print documents
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Samba client
  # reference: https://nixos.wiki/wiki/Samba
  # fileSystems."/mnt/share/Tank" = {
  #   options = let
  #     device = "//10.178.0.81/Tank";
  #     fsType = "cifs";
  #     opts = "iocharset=utf8";
  #     credentials = "/home/kev/.smbcredentials";

  #     in ["${opts},credentials=${credentials},uid=1000,gid=100"];
  # };

  # NixOS configuration (with HomeManager)
  system = {
    stateVersion = "23.11";
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "x86_64-linux";
  };

  nix = {
    # enable flake
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      # enable auto-cleanup
      auto-optimise-store = true;
      # set max-jobs
      max-jobs = lib.mkDefault 8;
    };
    # garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete older-than 7d";
    };
  };
}
