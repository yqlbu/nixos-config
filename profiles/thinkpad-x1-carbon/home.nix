_:

{
  imports = [
    # default home modules
    ../../home

    # host specific modules
    ./modules/dotfiles.nix
    ./modules/secrets.nix

    # shared modules
    (import ../../shared/modules/home/gnupg.nix ./conf/gpg.conf)
  ];
}
