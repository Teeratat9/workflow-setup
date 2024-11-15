return {
  "terrortylor/nvim-comment",
  config = function()
    require("nvim_comment").setup({
      -- Optional settings:
      line_mapping = "<C-/>", -- Line comment keybinding (usually Ctrl+/)
      operator_mapping = "<C-/>", -- Block comment keybinding
      comment_empty = false, -- Don't comment empty lines
    })
  end,
}
