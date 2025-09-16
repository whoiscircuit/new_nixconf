{config, pkgs, ... }:
{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.05";
 
  home.packages = with pkgs; [
    git
    stow
    htop
    kitty
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
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.symbols-only
    wofi
    firefox-esr
    dunst
    libnotify
    tealdeer
    bat
    pup
    jq
  ];

  programs.home-manager.enable = true;
}
