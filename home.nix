{config, pkgs, ... }:
{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.05";

  home.packages = with pkgs; [
    git
    stow
  ];

  programs.home-manager.enable = true;
}
