{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "system/services/scx.nix"
    "system/services/docker.nix"
    "system/services/atuin"

    # shared modules
    "shared/server/system/base.nix"
    # "shared/modules/system/tmpfs/persistent/server.nix"
  ]) ++ [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/networking.nix
  ];

  networking.hostName = "nixos-felix";
}
