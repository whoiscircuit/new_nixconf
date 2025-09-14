{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fonts.fontconfig.enable = true;
  fonts.fontconfig.includeUserConf = true;
  fonts.fontconfig.defaultFonts = {
    emoji = [];
    serif = [];
    sansSerif = [];
    monospace = [];
  };
  
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix";
      auth_fails = 5;
      hide_version_string = true;
      numlock = true;            
      session_log = ".cache/ly-session.log";
    };
  };
  programs.sway.enable = true;
  programs.hyprland.enable = true;

  networking.hostName = "vm"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "25.05"; # DON'T CHANGE

}
