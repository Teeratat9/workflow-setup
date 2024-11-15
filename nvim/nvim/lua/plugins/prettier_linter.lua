return {
  -- Prettier and ESLint via Null-LS
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            extra_filetypes = { "xml", "handlebars" }, -- Enable Prettier for XML and .hbs
          }),
          null_ls.builtins.diagnostics.eslint, -- ESLint diagnostics
          null_ls.builtins.formatting.eslint, -- ESLint formatting (optional)
        },
      })

      -- Auto-format on save for additional filetypes including .hbs and .xml
      vim.cmd([[
        autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json,*.css,*.scss,*.html,*.hbs,*.xml lua vim.lsp.buf.format()
      ]])

      -- Set .hbs files to be recognized as HTML for syntax highlighting
      vim.cmd([[
        autocmd BufRead,BufNewFile *.hbs set filetype=html
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
  -- Treesitter with support for additional languages
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "html", "javascript", "typescript", "css", "xml", "handlebars" }, -- Add XML and Handlebars
        sync_install = false, -- ไม่ sync ติดตั้ง parser
        ignore_install = {}, -- ไม่ละเว้นการติดตั้งภาษาใดๆ
        auto_install = true, -- ติดตั้ง parser อัตโนมัติเมื่อเปิดไฟล์
        highlight = {
          enable = true, -- เปิดใช้งาน syntax highlighting
        },
        modules = {},
      })
    end,
  },
}
