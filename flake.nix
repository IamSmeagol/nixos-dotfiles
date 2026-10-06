{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-espanso.url = "github:nixos/nixpkgs/b55208305dc143fe991c10444ca3d7cfa5a9adb7";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-wsl,
      nixpkgs-espanso,
      ...
    }:
    {

      nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          host = "nixos";
          inherit nixpkgs-espanso;
        };

        modules = [
          ./configuration.nix
          ./hosts/desktop

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.will = import ./users/will.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          host = "wsl";
        };

        modules = [
          ./configuration.nix
          ./hosts/wsl
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          {

            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nixos = import ./users/nixos.nix;
              backupFileExtension = "backup";
            };

          }

          # home-manager.nixosModules.home-manager
          # {
          #   home-manager = {
          #     useGlobalPkgs = true;
          #     useUserPackages = true;
          #     users.will = import ./home.nix;
          #     backupFileExtension = "backup";
          #   };
          # }
        ];
      };

    };
}
