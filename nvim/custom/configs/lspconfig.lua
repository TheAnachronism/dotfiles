local on_attach = require("plugins.configs.lspconfig").on_attach
local capabiltities = require("plugins.configs.lspconfig").capabiltities

local lspconfig = require "lspconfig"

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabiltities = capabiltities,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
})
