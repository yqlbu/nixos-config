{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  hardware.enableAllFirmware = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" ];

  # Use the systemd-boot UEFI loader.
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  # Remove the fsck that runs at startup. It will always fail to run, stopping your boot until you press *.
  boot.initrd.checkJournalingFS = false;
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4d03b3c4-14ac-4c96-baea-72c7d82b47aa";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/4d03b3c4-14ac-4c96-baea-72c7d82b47aa";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/5E78-9CB1";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4cc0f15c-89e4-45cd-acda-d9b70b478b44"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.

  # NIC
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    interfaces = {
      ens18 = {
        ipv4.addresses = [{
          address = "10.178.0.51";
          prefixLength = 24;

        }];
      };
    };
    defaultGateway = "10.178.0.5";
    nameservers = ["10.178.0.5"];
  };


  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
}
