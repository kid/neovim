{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
let
  # renovate: datasource=github-releases depName=smart-splits-nvim/backend-ghostty
  tag = "v1.0.1";
in
vimUtils.buildVimPlugin {
  pname = "smart-splits-backend-ghostty";
  version = lib.removePrefix "v" tag;

  src = fetchFromGitHub {
    owner = "smart-splits-nvim";
    repo = "backend-ghostty";
    inherit tag;
    hash = "sha256-pAcYJJ+T6Fq/k2uTQ4cL7lKWz4NCnsX+EmUKh/5UwT4=";
  };

  meta = {
    description = "Ghostty backend for smart-splits.nvim v3 (macOS only)";
    homepage = "https://github.com/smart-splits-nvim/backend-ghostty";
    license = lib.licenses.mit;
  };
}
