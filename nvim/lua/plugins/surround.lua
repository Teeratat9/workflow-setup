return {
  "tpope/vim-surround",
  event = "VeryLazy", -- Load lazily to improve startup time
  config = function()
    -- No specific configuration needed for vim-surround
    -- The plugin works out of the box
    -- Example usage:
    --   - `ysiw'` to surround a word with single quotes
    --   - `ds'` to delete surrounding single quotes
    --   - `cs"'` to change single quotes to double quotes
  end,
}
