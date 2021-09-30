{
  description = "Clayton's system configuration.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-master.url = "nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = inputs@{
    self
    , nixpkgs
    , nixpkgs-master
    , home-manager
    , nixos-hardware
    , ...
  }: let
    inherit (lib.my) mapModules mapModulesRec mapHosts;

    system = "x86_64-linux";

    mkPkgs = pkgs: extraOverlays: import pkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = extraOverlays;
    };
    pkgs = mkPkgs nixpkgs [];
    master = mkPkgs nixpkgs-master [];

    lib = nixpkgs.lib.extend
      (self: super: { my = import ./lib { inherit pkgs inputs; lib = self; }; });

    home = [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.claytonjgilmer = lib.mkMerge [
          ./home.nix
        ];
      }
    ];

    common = { pkgs, config, ... }: {
      config = {
        nix = {
          binaryCachePublicKeys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          ];
          binaryCaches = [
            "https://cache.nixos.org"
          ];
        };
      };
    };

  in {
    packages."${system}" =
      mapModules ./packages (p: pkgs.callPackage p {});

    nixosConfigurations = {
      # HP Envy x360
      envy = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/envy.nix
          common
        ] ++ home;
        specialArgs = {
          inherit inputs;
          inherit home-manager;
        };
      };
    };
  };
}
