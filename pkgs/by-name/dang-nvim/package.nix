{
  lib,
  vimUtils,
  tree-sitter,
  inputs,
}:
let
  src = inputs.dang-nvim;
  date = src.lastModifiedDate;

  grammar = tree-sitter.buildGrammar {
    language = "dang";
    # Must equal tree-sitter.json's metadata.version or buildGrammar logs an error.
    inherit ((lib.importJSON "${inputs.dang}/treesitter/tree-sitter.json").metadata) version;
    src = "${inputs.dang}/treesitter";
    # Zed queries, symlinked into ../editors/zed (dangling here); dang.nvim ships the Neovim ones.
    postPatch = "rm -r queries";
  };
in
vimUtils.buildVimPlugin {
  pname = "dang-nvim";
  version = "0-unstable-${lib.substring 0 4 date}-${lib.substring 4 2 date}-${lib.substring 6 2 date}";
  inherit src;

  postInstall = ''
    mkdir -p $out/parser
    ln -s ${grammar}/parser $out/parser/dang.so
  '';

  meta = {
    description = "Dang filetype, Tree-sitter queries and parser for Neovim";
    homepage = "https://github.com/vito/dang.nvim";
    license = lib.licenses.mit;
  };
}
