return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
      },
      filters = {
        dotfiles = false, -- Show hidden files
      },
      git = {
        enable = true,
        ignore = false, -- Show ignored files
      },
    })
  end,
}

