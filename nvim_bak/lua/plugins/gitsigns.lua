-- plugin/gitsigns.lua
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      current_line_blame = true, -- Enables inline blame for the current line
      current_line_blame_opts = {
        delay = 500, -- Set delay for the blame display
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    })
  end,
}
