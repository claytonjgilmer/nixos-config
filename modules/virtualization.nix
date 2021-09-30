{ config, pkgs, inputs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemuOvmf = true;
      qemuRunAsRoot = false;
    };
  };

  environment.systemPackages = with pkgs; [
    qemu
    gnome-boxes
    virt-manager
  ];
}
