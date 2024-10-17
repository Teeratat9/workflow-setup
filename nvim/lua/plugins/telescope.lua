return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        -- Exclude the node_modules directory
        file_ignore_patterns = { "node_modules" },
      },
    })
       -- Key mapping for live grep
    vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope live_grep<CR>', { noremap = true, silent = true })
  end,
}

