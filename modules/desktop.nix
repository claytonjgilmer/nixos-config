{ config, pkgs, inputs, ... }:

{
  services.xserver = {
    enable = true;
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
    gnome.gnome-keyring
    gnome.gnome-terminal
    gnome.gnome-tweaks
    gnome.nautilus
    firefox
    discord
  ];
}
