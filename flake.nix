{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    mnw.url = "github:Gerg-L/mnw";

    systems.url = "github:nix-systems/default";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    npins.url = "github:andir/npins";
    npins.flake = false;

    blink-cmp.url = "github:saghen/blink.cmp/v1.8.0";
    blink-pairs.url = "github:saghen/blink.pairs/v0.4.1";
  };

  outputs =
    inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (_: {
      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      systems = import systems;

      perSystem =
        {
          lib,
          pkgs,
          system,
          self',
          inputs',
          ...
        }:
        let
          inherit (inputs) mnw npins;
        in
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfreePredicate =
              pkg:
              builtins.elem (lib.getName pkg) [
                "copilot-language-server"
              ];
          };

          treefmt = {
            flakeCheck = true;
            programs = {
              nixfmt.enable = true;
              stylua.enable = true;
            };
          };

          packages = {
            default = self'.packages.neovim;

            neovim = mnw.lib.wrap { inherit pkgs inputs inputs'; } ./config.nix;

            dev = self'.packages.default.devMode;
            inherit (self'.packages.default) configDir;

            npins = pkgs.callPackage (npins + /npins.nix) { };
          };

          devShells.default = pkgs.mkShellNoCC {
            packages =
              with pkgs;
              [
                opencode
                stylua
                deadnix
                statix
              ]
              ++ [ self'.packages.dev ]
              # FIXME: Npins is  broken on Darwin
              ++ lib.optionals (!pkgs.stdenv.isDarwin) [
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
