return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- css/scss round out the frontend stack; snacks.image also needs a parser
      -- for any filetype it should render images inside.
      ensure_installed = { "css", "scss", "vue" },
    },
  },
}
