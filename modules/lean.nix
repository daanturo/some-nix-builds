toplevel@{
  inputs,
  forEachSupportedSystem,
  lib,
  ...
}:
let
in
{
  packages = forEachSupportedSystem (
    {
      system,
      pkgs,
      pkgs-unstable,
      ...
    }:
    {

      # https://github.com/wvhulle/pretty-lean/blob/84c8a180d872c376bdab1b280b36669883f2a5be/flake.nix#L243-L247
      lean = inputs.pretty-lean4.packages.${system}.lean;
      lake = inputs.pretty-lean4.packages.${system}.lake;
      leanc = inputs.pretty-lean4.packages.${system}.leanc;
      leanchecker = inputs.pretty-lean4.packages.${system}.leanchecker;
      leanmake = inputs.pretty-lean4.packages.${system}.leanmake;

    }
  );
}
