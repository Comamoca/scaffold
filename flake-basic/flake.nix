{
  description = "A basic flake to with flake-parts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{
      self,
      systems,
      nixpkgs,
      treefmt-nix,
      flake-parts,
    }:
    # let
    #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #   stdenv = pkgs.stdenv;
    #   treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    # in
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ treefmt-nix.flakeModule ];
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
            buildPhase = '''';

            # Write build commands. e.g. install file $out/bin/file
            installPhase = '''';
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
        rec {
          # When execute `nix fmt`, formatting your code.
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };

            settings.formatter = { };
          };

          # When execute `nix develop`, you go in shell installed nil.
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nil
            ];
          };

          packages.default = hello;
        };
    };
}
