{ config, ... }:

{
  sops.secrets = {
    "minio/config" = {
      sopsFile = ../../secrets/minio.enc.yaml;
      mode = "0600";
      path = "${config.home.homeDirectory}/.mc/config.json";
    };
  };
}
