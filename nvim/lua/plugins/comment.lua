return {
  "terrortylor/nvim-comment",
  config = function()
    require('nvim_comment').setup({
      -- Add any configuration here if needed
      --         -- Optional settings:
        line_mapping = "<leader>cl", -- Line comment keybinding
        operator_mapping = "<leader>c", -- Block comment keybinding
        comment_empty = false, -- Don't comment empty lines
    })
  end,
}

