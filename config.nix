{
  lib,
  pkgs,
  inputs',
  ...
}:
let
  # mnw uses the attribute name as the pack/ directory name, which is what lze
  # packadd's. nixpkgs sets pname to the upstream repo name, so derive it.
  byName =
    plugins:
    lib.listToAttrs (
      map (p: lib.nameValuePair (lib.removePrefix "vimplugin-" (lib.getName p)) p) plugins
    );
in
{
  inherit (inputs'.neovim-nightly.packages) neovim;

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
    startAttrs = byName (
      with pkgs.vimPlugins;
      [
        nvim-treesitter
        nvim-treesitter-textobjects

        jinja-vim
        lze
        lzextras
        plenary-nvim

        # runtime dependency of blink.pairs
        blink-lib
      ]
    );

    optAttrs = byName (
      with pkgs.vimPlugins;
      [
        blink-cmp
        blink-copilot
        blink-pairs
        colorful-menu-nvim
        conform-nvim
        diffview-nvim
        flash-nvim
        friendly-snippets
        fyler-nvim
        gitsigns-nvim
        gruvbox-nvim
        helm-ls-nvim
        lazydev-nvim
        lspkind-nvim
        lualine-nvim
        luasnip
        mini-icons
        neogit
        noice-nvim
        nui-nvim
        nvim-lspconfig
        nvim-surround
        nvim-web-devicons
        opencode-nvim
        quicker-nvim
        render-markdown-nvim
        smart-splits-nvim
        snacks-nvim
        todo-comments-nvim
        trouble-nvim
        which-key-nvim
      ]
    );
  };

  extraBinPath = with pkgs; [
    sqlite
    ripgrep
    copilot-language-server

    # for opencode
    lsof
  ];

  extraLuaPackages = ps: [ ps.jsregexp ];
}
