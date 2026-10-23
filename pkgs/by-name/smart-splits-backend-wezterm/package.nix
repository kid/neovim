# Ships both halves: the Neovim backend (lua/) and the WezTerm GUI plugin
# (plugin/), which nixfiles loads from this store path.
{
  lib,
  vimUtils,
  inputs,
}:
let
  src = inputs.smart-splits-backend-wezterm;
  date = src.lastModifiedDate;
in
vimUtils.buildVimPlugin {
  pname = "smart-splits-backend-wezterm";
  version = "0-unstable-${lib.substring 0 4 date}-${lib.substring 4 2 date}-${lib.substring 6 2 date}";
  inherit src;

  meta = {
    description = "WezTerm backend for smart-splits.nvim v3";
    homepage = "https://github.com/smart-splits-nvim/backend-wezterm";
    license = lib.licenses.mit;
  };
}
