local M = {}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>gg"] = {"<cmd> LazyGit<CR>", "LazyGit"},
  },
}

require("core.utils").load_mappings("lazygit")
return M
