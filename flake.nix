{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { nixpkgs, home-manager, nixos-wsl, ... }: {

    nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        host = "nixos";
      };

      modules = [
        ./configuration.nix
        ./hosts/desktop

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.will = import ./home.nix;
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
