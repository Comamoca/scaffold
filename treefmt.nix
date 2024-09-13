{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    deno.enable = true;
    # TODO: Add haxe formatter.
  };

  settings.formatter =
    {
    };
}
