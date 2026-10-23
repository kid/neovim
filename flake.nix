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
  };

  outputs =
    inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (_: {
      imports = [
        inputs.treefmt-nix.flakeModule
      ];

      flake.overlays.default = _: prev: {
        my-neovim = inputs.self.packages.${prev.stdenv.hostPlatform.system}.neovim;
      };

      systems = import systems;

      perSystem =
        {
          lib,
          config,
          pkgs,
          system,
          self',
          inputs',
          ...
        }:
        let
          inherit (inputs) mnw;
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
          };

          checks.startup =
            pkgs.runCommand "neovim-startup-check"
              {
                nativeBuildInputs = [ self'.packages.neovim ];
              }
              ''
                export HOME="$TMPDIR"
                export NVIM_STARTUP_REPORT="$TMPDIR/report"
                if ! timeout 120 nvim --headless --cmd "luafile ${./tests/startup.lua}" </dev/null >"$TMPDIR/log" 2>&1; then
                  echo "neovim startup failed:" >&2
                  cat "$NVIM_STARTUP_REPORT" >&2 || cat "$TMPDIR/log" >&2
                  exit 1
                fi
                touch "$out"
              '';

          devShells.default = pkgs.mkShellNoCC {
            inputsFrom = [ config.treefmt.build.devShell ];
            packages = with pkgs; [
              lua-language-server
              stylua
              deadnix
              statix

              self'.packages.dev
            ];
          };
        };
    });
}
