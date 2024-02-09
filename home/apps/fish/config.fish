##
##  | | _______   __           HIKARI AI
##  | |/ / _ \ \ / /           https://hikariai.net
##  |   <  __/\ V /            https://link.hikariai.net
##  |_|\_\___| \_/             https://github.com/yqlbu
##
##  My fish shell config. Nothing fancy, but I like it

### PATH ###
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.npm-global/bin
fish_add_path $HOME/.local/scripts
fish_add_path $HOME/go/bin
fish_add_path $HOME/.nix-profile/bin
# fish_add_path $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
# fish_add_path /usr/lib/jvm/default-runtime/bin

### Link Sources ###
source $HOME/.config/fish/themes/cool-beans-nix.fish
source $HOME/.config/fish/functions/bangbang.fish
source $HOME/.config/fish/functions/gnupg.fish

### General Settings ###
set fish_greeting # Turns off the intro message when pulling up fish shell
set EDITOR "nvim" # Sets the $EDITOR to vim

export CLICOLOR=1
export LS_COLORS=(vivid generate nord)
export LC_ALL=C.UTF-8

# export SOPS_PGP_FP=""
# export SOPS_AGE_KEY=(age -i $HOME/.age/age-yubikey-identity.txt -d $HOME/.age/age-yubikey-master.enc.key)
# export SOPS_AGE_RECIPIENTS=(cat $HOME/.age/age-yubikey-master.pub)
# export SOPS_AGE_KEY_FILE=$HOME/.age/age-yubikey-master.key

## Java
export JAVA_HOME=/usr/lib/jvm/default

### Fish Alias ###
abbr unset "set --erase"

### Shortcuts ###
abbr ..  "cd .."
abbr ... "cd ../../"
abbr home "cd ~"
abbr vim "nvim"
abbr lg "lazygit"
abbr ld "lazydocker"
abbr ra "ranger"
abbr edit "notepadqq"
abbr top "btop"
abbr weather "curl wttr.in/"

# system
abbr ls "ls -ltrh"
abbr du "du -d 1 -h"
abbr rm "trash -v"

# journalctl
abbr journal "journalctl -xefu"

# neofetch
abbr logo "neofetch"

# package manager related
abbr pacsyu "sudo pacman -Syyu --noconfirm"
abbr yaysyu "paru -Syyu --noconfirm"
alias yay="paru"

# kubernetes related
abbr k "kubectl"
abbr kz "kubectl kustomize"

# git related
abbr gs "git status"
abbr gc "git checkout"
abbr gp "git pull"
abbr gpp "git push -u origin"
abbr gpu "git push -u upstream"
abbr gf "git fetch origin --prune"
abbr gfu "git fetch upstream --prune"
abbr gl "git log --all --decorate --oneline --graph"
abbr gcc "git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D"
abbr gcb "git checkout -b"
abbr gcm "git commit -m"
abbr gca "git commit --amend"
abbr gpp "git push -u origin"
abbr gd "git diff"
abbr gadd "git add ."

# nixos
abbr rebuild "sudo nixos-rebuild switch --upgrade --flake .#nixos"
abbr prefetch-git "nix-prefetch-git --url 'https://github.com/yqlbu/' --rev 'refs/heads/x1-carbon'"
abbr clean "sudo nix-collect-garbage -d"
abbr update "sudo nix flake update"
abbr update-input "sudo nix flake lock --update-input"
abbr sync-secrets "git submodule update --recursive --remote --merge"

# flux
abbr fra "flux reconcile kustomization flux-system --with-source"
abbr fga "flux get all -A"

# ssh
abbr ssh "kitten ssh"

# ripgrep
abbr rgf "rg --files | rg"

# program
abbr icat "imv"

### Device Control ###

# audio
abbr get-audio-out "$HOME/.local/scripts/get-audio-out"
abbr set-audio-out "pactl set-default-sink"

# brightnessctl
abbr kbd_backlight_off "brightnessctl --device='tpacpi::kbd_backlight' set 0"
abbr kbd_backlight_on "brightnessctl --device='tpacpi::kbd_backlight' set 1"

# audio (wirepulmer)
abbr get-vol "wpctl get-volume @DEFAULT_AUDIO_SINK@"
abbr set-vol "wpctl set-volume @DEFAULT_AUDIO_SINK@"

# audio (pamixer)
# abbr get-vol "pamixer --get-volume"
# abbr set-vol "pamixer --set-volume"
# pb
alias pb="curl -F 'c=@-' https://fars.ee/"
# snips
alias snips="ssh snips.sh"

### Dev ENV ###

# fzf key-remaps
fzf_configure_bindings --git_status --history=\ch --variables=\cv --directory=\cx --git_log=\cg

# lf history work-dir
bind \co 'set old_tty (stty -g); stty sane; lf; stty $old_tty; commandline -f repaint'

# zoxide
zoxide init fish | source
