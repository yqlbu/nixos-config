{ inputs, pkgs, user, lib, ... }:

with lib;
let
  keyFiles = [
    "${inputs.home-estate}/authorized_keys"
  ];
in
{
  users.users = {
    ${user} = {
      isNormalUser = true;
      extraGroups = mkDefault [ "networkmanager" "wheel" "docker" "libvirtd" ];
      home = "/home/${user}";
      shell = pkgs.fish;
      # /etc/ssh/authorized_keys.d/${user}
      openssh.authorizedKeys.keyFiles = keyFiles;
      packages = with pkgs; [ fish ];
    };

    root = {
      shell = pkgs.bash;
    };
  };
}
