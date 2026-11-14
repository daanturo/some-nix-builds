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

      # # ERROR: git fetch' failed. This might be due to the dumb transfer protocol not supporting shallow fetch or no-tag cloning. Trying with --tags' and without `--depth=1'...
      # # error: RPC failed; HTTP 500 curl 22 The requested URL returned error: 500
      # # fatal: expected 'packfile'
      # # Unable to checkout [HEX] from https://https.git.savannah.gnu.org/git/emacs.git.
      emacs-igc-pgtk = inputs.emacs-overlay.packages.${system}.emacs-igc-pgtk;

      # cache packages native compilations?

    }
  );
}
