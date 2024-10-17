return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = {
          enabled = true,  -- Enable follow current file
        },
        filtered_items = {
          visible = true,  -- Show hidden files
        },
      },
    })
  end,
}

