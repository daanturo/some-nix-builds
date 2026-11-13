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

      emacs-igc-pgtk = inputs.emacs-overlay.packages.${system}.emacs-igc-pgtk;

    }
  );
}
