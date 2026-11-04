--- @type vim.lsp.Config
return {
  cmd = { "dang", "--lsp" },
  filetypes = { "dang" },
  -- The server fails `initialize` without a rootUri.
  workspace_required = true,
  root_markers = { "dang.toml", "dagger-module.toml", "dagger.toml", "dagger.json", ".git" },
}
