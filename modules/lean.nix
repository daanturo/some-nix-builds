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
    { pkgs, system, ... }: {

      # https://github.com/wvhulle/pretty-lean/blob/master/flake.nix#L243
      lean = inputs.pretty-lean4.packages.${system}.lean;
      lake = inputs.pretty-lean4.packages.${system}.lake;
      leanc = inputs.pretty-lean4.packages.${system}.leanc;
      leanchecker = inputs.pretty-lean4.packages.${system}.leanchecker;
      leanmake = inputs.pretty-lean4.packages.${system}.leanmake;

    }
  );
}
