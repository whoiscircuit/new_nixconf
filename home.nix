{config, pkgs, inputs, unstable, ... }:
{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.05";
 
  home.packages = with pkgs; [
    git
    stow
    htop
    unstable.kitty
    difftastic
    alacritty
    wezterm
    foot
    vscode
    rxvt-unicode-emoji
    vazir-code-font
    vazir-fonts
    iozevka-nerd
    iozevka-mono
    iozevka-quasi
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.symbols-only
    wofi
    dunst
    libnotify
    tealdeer
    bat
    pup
    jq
    direnv
    asciinema_3
    sxiv
    gifsicle
    asciinema-agg
    wl-clipboard
    lsd
    gtrash
    qrencode
    python314
    qmk
    gruvbox-material-gtk-theme
    v2rayn
    hyprcursor
    qt6ct
    vlc
    bitwarden-desktop
    unzip
    emacs
    apple-emoji-nix
    ashell
    hyprpaper
  ];

  programs.firefox = {
    enable = true;
    package = unstable.firefox;
    policies = (builtins.fromJSON (builtins.readFile "${inputs.dotfiles.outPath}/.config/firefox/policies.json")).policies;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  services.kdeconnect.enable = true;

  programs.home-manager.enable = true;
}
