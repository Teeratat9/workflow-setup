return {
  -- Prettier and ESLint via Null-LS
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier, -- Prettier formatting
          null_ls.builtins.diagnostics.eslint, -- ESLint diagnostics
          null_ls.builtins.formatting.eslint, -- ESLint formatting (optional)
        },
      })

      -- Auto-format on save
      vim.cmd([[
        autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json,*.css,*.scss,*.html lua vim.lsp.buf.format()
      ]])
    end,
  },
  -- Optionally, add 'mason.nvim' and 'mason-lspconfig.nvim' for automatic installation of tools
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "eslint" }, -- Automatically install ESLint
      })
    end,
  },
  {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  },
}
