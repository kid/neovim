{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    mnw.url = "github:Gerg-L/mnw";

    systems.url = "github:nix-systems/default";

    npins.url = "github:andir/npins";
    npins.flake = false;
  };

  outputs =
    inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (_: {
      systems = import systems;

      perSystem =
        {
          pkgs,
          self',
          ...
        }:
        let
          inherit (inputs) mnw npins;
        in
        {
          packages = {
            default = self'.packages.neovim;

            neovim = mnw.lib.wrap { inherit pkgs inputs; } ./config.nix;

            dev = self'.packages.default.devMode;
            inherit (self'.packages.default) configDir;

            npins = pkgs.callPackage (npins + /npins.nix) { };
          };

          devShells.default = pkgs.mkShellNoCC {
            packages = [
              pkgs.opencode
              self'.packages.dev
              self'.packages.npins
              (pkgs.writeShellScriptBin "start" ''
                npins --lock-file ./npins/start.json "$@"
              '')
              (pkgs.writeShellScriptBin "opt" ''
                npins --lock-file ./npins/opt.json "$@"
              '')
            ];
          };
        };
    });
}
