
{ config, lib, pkgs, modulesPath, inputs, ... }:

{
  imports =
    [
      inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
      (modulesPath + "/installer/scan/not-detected.nix")
      ../modules/common.nix
      ../modules/desktop.nix
      ../modules/develop.nix
      ../modules/fonts.nix
      ../modules/media.nix
      ../modules/virtualization.nix
    ];

  time.timeZone = "US/Eastern";

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" ];
      kernelModules = [ ];
    };

    kernelModules = [
      "kvm-intel"
    ];
  };

  networking = {
    hostName = "envy";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "btrfs";
    options = [
      "compress=zstd"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  environment.systemPackages = with pkgs; [
    sof-firmware
  ];
}
