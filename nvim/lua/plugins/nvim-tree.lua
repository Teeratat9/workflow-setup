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
        dotfiles = true, -- Show hidden files
      },
      git = {
        enable = true,
        ignore = false, -- Show ignored files
      },
    })
  end,
}

