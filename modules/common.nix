{ config, pkgs, inputs, ... }:

{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than-7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  nixpkgs.config.allowUnfree = true;

  users.users.claytonjgilmer = {
    description = "me";
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
  };

  security = {
    apparmor = {
      enable = true;
    };

    sudo.enable = false;

    doas = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  networking = {
    wireless = {
      iwd = {
        enable = true;
      };
    };
    
    firewall.enable = true;    

    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    coreutils
    bash
    zsh
    vim
    openssh
    git
    wget
    htop
    zip
    unzip
  ];
}
