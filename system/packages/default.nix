{ pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nix-prefetch-scripts
    tmux
    tree
    vim
    wget
    lm_sensors

    # fish-related
    fishPlugins.fzf-fish
    # notification
    libnotify
  ];
}
