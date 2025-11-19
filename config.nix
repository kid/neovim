{
  lib,
  pkgs,
  inputs',
  ...
}:
let
  npinsToPlugins =
    input: builtins.mapAttrs (_: v: v { inherit pkgs; }) (import ./npins { inherit input; });
in
{
  appName = "nvim-kid-mnw";

  initLua =
    # lua
    ''
      require("config")
    '';

  plugins = {
    dev.config = {
      pure =
        let
          fs = lib.fileset;
        in
        fs.toSource {
          root = ./.;
          fileset = fs.unions [
            ./after
            ./lua
          ];
        };
      impure = "~/Code/kid/neovim";
    };

    start = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
    startAttrs = npinsToPlugins ./npins/start.json;

    optAttrs = {
      "blink.cmp" = inputs'.blink-cmp.packages.default;
      "blink.pairs" = inputs'.blink-pairs.packages.default;
    }
    // npinsToPlugins ./npins/opt.json;
  };

  extraBinPath = with pkgs; [
    deadnix
    statix
    nil
    nixd

    lua-language-server
    stylua

    sqlite
  ];
}
