{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      stdenv = pkgs.stdenv;
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    in
    {
      # Run treefmt. See `./treefmt.nix`.
      formatter.x86_64-linux = treefmtEval.config.build.wrapper;

      # When execute `nix develop`, you go in shell installed nil.
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          nil
        ];
      };

      templates.default = {
        path = ./.;
        description = "Nix flake basic template.";
      };

      # To make executable binary.
      executable = stdenv.mkDerivation {
        # Set executable binary name.
        pname = "executable";
        version = "0.0.1";
        # Specify source path. You must specify the file added with `git add`.
        src = ./.;
        # Write build commands. e.g. make, gcc, etc...
        buildCommand = '''';
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

      packages.x86_64-linux.default = self.hello;
    };
}
