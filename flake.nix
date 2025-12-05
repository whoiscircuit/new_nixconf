{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    iozevka.url = "github:whoiscircuit/iozevka";
    iozevka.inputs.nixpkgs.follows = "nixpkgs";
    dotfiles.url = "github:whoiscircuit/new_dotfiles";
    dotfiles.flake = false;
    hidrosis.url = "git+https://github.com/whoiscircuit/daktylos?submodules=1";
    hidrosis.inputs.nixpkgs.follows = "nixpkgs";
    apple-emoji-nix.url = "github:whoiscircuit/apple-emoji-nix";
    apple-emoji-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager,... }@inputs: 
  let
    system = "x86_64-linux";
    overlays = [
      inputs.iozevka.overlays.default
      inputs.hidrosis.overlays.default
      inputs.apple-emoji-nix.overlays.default
    ];
    pkgs = import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };
    unstable = import inputs.nixpkgs-unstable {
      inherit system overlays;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.main = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      specialArgs = {inherit unstable;};
      modules = [
        inputs.hidrosis.nixosModules.default
        ./configuration.nix
      ];
    };
    homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
      extraSpecialArgs = {inherit inputs unstable;};
    };
  };
}
