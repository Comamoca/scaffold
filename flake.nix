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

      templates = {

        flake-basic = {
          path = ./flake-basic;
          description = "Nix flake basic template.";
        };

        c-cli = {
          path = ./c-cli;
          description = "Basic C project template.";
        };
        c-raylib-cmake = {
          path = ./c-raylib-cmake;
          description = "Raylib project build with cmake.";
        };
        deno-hono = {
          path = ./deno-hono;
          description = "Hono project with Deno.";
        };
        haxe-basic-cpp = {
          path = ./haxe-basic-cpp;
          description = "Haxe project with cpp target.";
        };
        honox-minimal = {
          path = ./honox-minimal;
          description = "Minimal HonoX project.";
        };
        odin-hello = {
          path = ./odin-hello;
          description = "Minimal Odin project.";
        };
        odin-hello = {
          path = ./cl-nix;
          description = "Common Lisp with Nix";
        };
      };
    };
}
