return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",  -- Ensures that dependencies are installed
    ft = { "markdown" },  -- Load plugin only for markdown files
    config = function()
      vim.g.mkdp_auto_start = 0  -- Prevent automatic preview on file open
      -- Keymap to toggle Markdown preview
      vim.api.nvim_set_keymap("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", { noremap = true, silent = true })

    end,
  }
}

