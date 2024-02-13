{
  # build system
  outputs = { self, nixpkgs, home-manager, hyprland, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      # use a system-specific version of nixpkgs
      # pkgs = (import nixpkgs) { inherit system; };
      inherit (nixpkgs) lib;
      inherit (import ./vars.nix) user;
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs system user; };
          modules = [
            ./profiles/thinkpad-x1-carbon/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs system user; };
                users.${user} = import ./home;
                sharedModules = [
                  sops-nix.homeManagerModules.sops
                ];
              };
            }
            hyprland.nixosModules.default
          ];
        };
      };
    };

  # define channels
  inputs = {
    # public source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    flake-utils.url = "github:numtide/flake-utils";
    daeuniverse.url = "github:daeuniverse/flake.nix/sync-upstream";
    helloworld.url = "github:yqlbu/helloworld.nix";

    # private repos
    secrets = {
      url = "git+file:./secrets?shallow=1";
      flake = false;
    };
    home-estate = {
      url = "git+file:./home-estate?shallow=1";
      flake = false;
    };

    # personal dotfiles
    dotfiles.url = "git+https://github.com/yqlbu/dotfiles.nix?ref=master";
    qutebrowser = {
      url = "github:yqlbu/dot-qutebrowser";
      flake = false;
    };
    nvim = {
      url = "github:yqlbu/dot-nvim";
      flake = false;
    };
    lf = {
      url = "github:yqlbu/dot-lf";
      flake = false;
    };
    lazygit = {
      url = "github:yqlbu/dot-lazygit";
      flake = false;
    };
    swappy = {
      url = "github:yqlbu/dot-swappy";
      flake = false;
    };
    rofi = {
      url = "github:yqlbu/dot-rofi/x1-carbon";
      flake = false;
    };
    swaylock = {
      url = "github:yqlbu/dot-swaylock/x1-carbon";
      flake = false;
    };
    waybar = {
      url = "github:yqlbu/dot-waybar/x1-carbon";
      flake = false;
    };
    tmux = {
      url = "github:yqlbu/dot-tmux/x1-carbon";
      flake = false;
    };
    fish = {
      url = "github:yqlbu/dot-fish/x1-carbon";
      flake = false;
    };
    hypr = {
      url = "github:yqlbu/dot-hypr/x1-carbon";
      flake = false;
    };
    dunst = {
      url = "github:yqlbu/dot-dunst/x1-carbon";
      flake = false;
    };
    kitty = {
      url = "github:yqlbu/dot-kitty/x1-carbon";
      flake = false;
    };

  };
}
