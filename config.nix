{
  lib,
  pkgs,
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
    opt = with pkgs.vimPlugins; [
      blink-cmp
    ];
    optAttrs = npinsToPlugins ./npins/opt.json;
  };

  extraBinPath = with pkgs; [
    deadnix
    statix
    nil

    lua-language-server
    stylua

    sqlite
  ];
}
