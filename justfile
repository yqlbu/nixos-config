# justfile
# cheatsheet: https://cheatography.com/linux-china/cheat-sheets/justfile/

# define alias
alias b := rebuild

# set options
set positional-arguments := true

# default recipe to display help information
default:
  @just --list

# rebuild nixos
rebuild host:
  @sudo nixos-rebuild switch --upgrade --flake .#{{ host }}

# update all flake inputs
update-all-inputs:
  @sudo nix flake update

# update a particular flake input
update-input input:
  @sudo nix flake lock --update-input {{ input }}

# nix-prefetch-url
prefetch-url url:
  @nix-prefetch-url --type sha256 '{{ url }}' | xargs nix hash to-sri --type sha256

# nix-prefetch-git
prefetch-git repo rev:
  @nix-prefetch-git --url 'git@github.com:{{ repo }}' --rev '{{ rev }}' --fetch-submodules
