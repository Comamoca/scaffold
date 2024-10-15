{
  description = "A basic flake to with flake-parts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
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
	  name = "mypkg";
          stdenv = pkgs.stdenv;

          cl-mypkg = pkgs.sbcl.buildASDFSystem {
            pname = name;
            version = "0.1.0";
            src = ./.;
            systems = [
              name
              "${name}/tests"
            ];

            lispLibs = with pkgs.sbcl.pkgs; [
              arrow-macros
              rove

	      # TODO: Use only in devshell.
	      slynk
            ];
          };

          sbcl' = pkgs.sbcl.withOverrides (
            self: super: {
              inherit cl-mypkg;
            }
          );

          lisp = sbcl'.withPackages (ps: [ ps.cl-mypkg ]);

	  build-script = pkgs.writeText "build.lisp"
	  ''
	    (require :asdf)
	    (asdf:load-system :${name})

            (sb-ext:save-lisp-and-die "${name}"
	      :toplevel #'${name}/${name}:main
	      :executable t
	      :purify t
	      #+sb-core-compression :compression
              #+sb-core-compression t
	    )
	  '';

          mypkg = stdenv.mkDerivation {
            pname = name;
            version = "0.0.1";
            src = ./.;
            nativeBuildInputs = [ pkgs.sbcl lisp pkgs.makeWrapper ];
	    dontStrip = true;

            buildPhase = ''
              ${lisp}/bin/sbcl --script ${build-script}
            '';

            installPhase = ''
	    install -D ${name} $out/bin/${name} 
	    '';
          };

	  test-script = pkgs.writeText "build.lisp"
	  ''
	    (require :asdf)
	    (asdf:load-system :rove)
	    ;; (asdf:load-system :${name})

	    (rove)
	  '';

          run-test = pkgs.writeShellScriptBin "run-test" ''
            ${lisp}/bin/sbcl --eval "(require :asdf)" \
	                     --eval "(asdf:test-system :mypkg)" \
	                     --eval "(exit)"
          '';

          run-slynk = pkgs.writeShellScriptBin "run-test" ''
            ${lisp}/bin/sbcl --eval "(require :asdf)" \
	                     --eval "(asdf:load-system :slynk)" \
	                     --eval "(slynk:create-server :dont-close t :style :spawn)"
          '';
        in
        rec {
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };

            settings.formatter = { };
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
	      lisp
              nil
            ];
          };

          packages.default = mypkg;
	  
	  apps = {
	    default = {
              type = "app";
              program = self.packages.default;
	    };

	    test = {
              type = "app";
              program = run-test;
	    };

	    slynk = {
              type = "app";
              program = run-slynk;
	    };
	  };
        };
    };
}
