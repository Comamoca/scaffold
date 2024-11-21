{
  description = "A basic flake for purescript project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    haskell-flake.url = "github:srid/haskell-flake";
    purescript-overlay = {
      url = "github:thomashoneyman/purescript-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      systems,
      nixpkgs,
      treefmt-nix,
      flake-parts,
      purescript-overlay,
      haskell-flake
      # flake-root,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ treefmt-nix.flakeModule 
      haskell-flake.flakeModule
      # flake-root.flakeModule 
      ];
      systems = import inputs.systems;

      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        let
          stdenv = pkgs.stdenv;

          executable = stdenv.mkDerivation {
            pname = "executable";
            version = "0.0.1";
            src = ./.;

            buildPhase = '''';

            installPhase = '''';
          };
        in {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              purescript-overlay.overlays.default
            ];
            config = { };
          };
        
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };

            settings.formatter = { };
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              purs
              spago-unstable
              purs-tidy-bin.purs-tidy-0_10_0
              purs-backend-es

              esbuild

              purescript-language-server
              nil
            ];
          };

          packages.default = executable;
        };
    };
}
