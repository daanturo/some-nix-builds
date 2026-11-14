{

  # inputs.nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst"; # unstable
  inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*"; # latest stable
  inputs.import-tree.url = "github:denful/import-tree";

  outputs = (
    inputs@{
      self,
      nixpkgs,
      ...
    }:
    let
      lib = nixpkgs.lib;
      supportedSystems = [ "x86_64-linux" ];
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs { inherit system; };
            system = system;
          }
        );
      config-by-import-tree = (
        (inputs.nixpkgs.lib.evalModules {
          specialArgs = { inherit inputs forEachSupportedSystem lib; };
          modules = [
            (inputs.import-tree ./modules)
            {
              options.packages = lib.mkOption {
                type = lib.types.attrsOf (lib.types.attrsOf lib.types.unspecified);
                default = { };
              };
            }
          ];
        }).config
      );
    in
    (lib.foldl' lib.recursiveUpdate { } [
      config-by-import-tree
      {
        # trick to build all packages with 'nix flake check' https://github.com/NixOS/nix/issues/7165#issuecomment-3396300462
        checks = (
          forEachSupportedSystem (
            { pkgs, system, ... }:
            (lib.mapAttrs' (name: lib.nameValuePair "package-${name}") (
              config-by-import-tree.packages.${system} or { }
            ))
          )
        );
      }
    ])

  );

  inputs.pretty-lean4.url = "github:wvhulle/lean4";
  # inputs.pretty-lean4.inputs.nixpkgs.follows = "nixpkgs";

  inputs.emacs-overlay.url = "github:nix-community/emacs-overlay";
  # inputs.emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

}
