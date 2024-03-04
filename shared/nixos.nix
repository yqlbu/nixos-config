{ pkgs, lib, user, system, ... }:

{
  # Ref: https://nixos.wiki/wiki/Nixos-rebuild
  nix = {
    # enable flake
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      # enable auto-cleanup
      auto-optimise-store = true;
      # set max-jobs
      max-jobs = lib.mkDefault 8;
      # enable ccache (local compilation)
      # extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
      trusted-users = [ user ];
      # trusted-public-keys = [ ];

      # substituers will be appended to the default substituters when fetching packages
      extra-substituters = [
        # "https://hyprland.cachix.org"
      ];
      extra-trusted-public-keys = [
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    # garbage collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete older-than 3d";
    };
  };

  system = {
    inherit (import ../shared/vars) stateVersion;
    autoUpgrade = {
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault system;
}
