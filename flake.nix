{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    iozevka.url = "github:whoiscircuit/iozevka";
    iozevka.inputs.nixpkgs.follows = "nixpkgs";
    dotfiles.url = "github:whoiscircuit/new_dotfiles";
    dotfiles.flake = false;
    hidrosis.url = "git+https://github.com/whoiscircuit/daktylos?submodules=1";
    hidrosis.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager,... }@inputs: 
  let
    system = "x86_64-linux";
    overlays = [
      inputs.iozevka.overlays.default
      inputs.hidrosis.overlays.default
    ];
    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      modules = [
        inputs.hidrosis.nixosModules.default
        ./configuration.nix
      ];
    };
    homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
      extraSpecialArgs = {inherit inputs;};
    };
  };
}
