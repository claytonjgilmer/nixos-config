# My NixOS config

Based heavily on https://github.com/pimeys/nixos, without this as a guide this setup would not have been possible.

## New install guide

1. `git clone https://github.com/claytonjgilmer/nixos-config /tmp/nixos`
1. Do partitioning/mounting steps (look at hosts to see which partitions need to be present & mounted)
1. `mv /tmp/nixos /mnt/etc/nixos`
1. `nixos-generate-config --root /mnt --show-hardware-config`
1. Add output of the previous file to a new config in `hosts`
1. Add the new host to `flake.nix`
1. `nix-shell -p git nixFlakes`
1. Merge the hardware config with the dotfiles in `/mnt/etc/nixos`
1. Install NixOS: `nixos-install --root /mnt --flake /mnt/etc/nixos#XYZ`, where
   `XYZ` is [the host you want to install](hosts/).
1. Reboot!
1. Change your `root` and `$USER` passwords!
1. `chmod -R users /etc/nixos`
1. `ln -s /etc/nixos /home/claytonjgilmer/.config/nixpkgs`
