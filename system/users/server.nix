{ config, inputs, user, ... }:

{
  imports = [ ./default.nix ];

  users = {
    # generated by `mkpasswd -m scrypt`
    # we have to use initialHashedPassword here when using tmpfs for /
    # users.${user}.initialHashedPassword = (builtins.readFile config.sops.secrets."login/initialHashedPassword".path);
    users.${user}.initialHashedPassword = "$y$j9T$KG494fI2FbUnLwxq2nfLN0$bb.8E3.qRDxXWp091YxWgMOEXCuOIZG6O9bt4u9V82D";

    users.root = {
      inherit (config.users.users."${user}") initialHashedPassword;
      openssh.authorizedKeys.keyFiles = [ "${inputs.home-estate}/authorized_keys" ];
    };
  };
}
