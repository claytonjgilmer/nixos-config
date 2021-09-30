{ config, pkgs, inputs, ... }:

{
  services.xserver = {
    desktopManager = {
      gnome = {
        enable = true;
      };
    };
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gnome-keyring
    gnome-terminal
    gnome-tweaks
    nautilus
    firefox
    discord
  ];
}
