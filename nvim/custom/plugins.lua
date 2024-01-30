local plugins = {
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "preservim/vim-markdown",
    lazy = false,
    branch = "master",
    dependencies = {
      "godlygeek/tabular",
    }
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "rust-analyzer",
        "lua-language-server",
        "html-lsp",
        "prettier",
        "stylua",
        "marksman",
        "markdownlint",
      },
    },
  }
}
return plugins
