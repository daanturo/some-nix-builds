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

      # branch unstable-20250526 of pkgs.tree-sitter-grammars.tree-sitter-clojure
      # https://github.com/clojure-emacs/clojure-ts-mode#install-tree-sitter-grammars

      # # https://wiki.nixos.org/wiki/FFmpeg
      # ffmpeg = (
      #   (pkgs.ffmpeg-full.override { withUnfree = true; }).overrideAttrs (_: {
      #     doCheck = false;
      #   })
      # );

    }
  );
}
