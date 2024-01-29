local M = {}

M.tmuxNavigate = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateRight<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateDown<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateUp<CR", "window up" },
  }
}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>gg"] = {"<cmd> LazyGit<CR>", "LazyGit"},
  },
}

require("core.utils").load_mappings("tmuxNavigate")
require("core.utils").load_mappings("lazygit")
return M
