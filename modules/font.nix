{ config, lib, pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      corefonts
      ubuntu_font_family
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      dejavu_fonts
      jetbrains-mono
    ];
  };
}
