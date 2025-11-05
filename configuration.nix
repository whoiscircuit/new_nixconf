{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
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

  systemd.user.units."hidrosis.service".enable = true;
  
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

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ hplipWithPlugin foo2zjs ];

  environment.systemPackages = with pkgs; [
    hplipWithPlugin
  ];

  programs.sway.enable = true;
  programs.hyprland.enable = true;
  networking.hostName = "vm"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = rec {
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # kde-connect
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  programs.zsh.enable = true;
  programs.zsh.enableGlobalCompInit = false;

  hardware.keyboard.qmk.enable = true;

  services.hidrosis.enable = true; # my custom integration for daktylos keyboard

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.05"; # DON'T CHANGE

}
