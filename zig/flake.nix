{
  description = "A basic flake to with flake-parts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };

  outputs =
    inputs@{
      self,
      systems,
      nixpkgs,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.git-hooks-nix.flakeModule
        inputs.devenv.flakeModule
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

          # To make executable binary.
          executable = stdenv.mkDerivation {
            # Set executable binary name.
            pname = "executable";
            version = "0.0.1";
            # Specify source path. You must specify the file added with `git add`.
            src = ./.;

            # Write build commands. e.g. make, gcc, etc...
            buildPhase = "";

            # Write build commands. e.g. install file $out/bin/file
            installPhase = "";
          };

          # When execute `nix run`, print "Hello World!".
          # And execute `nix build` to make execute at `./result/bin/hello`.
          hello = stdenv.mkDerivation {
            pname = "hello";
            version = "0.1.0";
            src = pkgs.writeShellScriptBin "hello" ''
              echo Hello World!
            '';

            buildCommand = ''
              install -D $src/bin/hello $out/bin/hello
            '';
          };
        in
        {
          # When execute `nix fmt`, formatting your code.
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };

            settings.formatter = { };
          };

          pre-commit = {
            check.enable = true;
            settings = {
              hooks = {
                treefmt.enable = true;
                gitleaks = {
                  enable = true;
                  entry = "${pkgs.gitleaks}/bin/gitleaks protect --staged";
                  language = "system";
                };
                gitlint.enable = true;
              };
            };
          };

          # When execute `nix develop`, you go in shell installed nil.
          devenv.shells.default = {
            devenv.root = builtins.toString ./.;

            packages = [ pkgs.nil ];

            # Specify languages like this.
            # There is a limit to the number of languages for which the version attribute can be specified.
            languages = {
              zig = {
                enable = true;
              };
            };

            enterShell = "";
          };

          packages.default = hello;
        };
    };
}
