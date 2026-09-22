return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- basedpyright is installed with `uv tool install basedpyright`, which
        -- ships its own Python. Mason's installer would use `python3` from the
        -- PATH, which pyenv currently pins to 3.5.10 — too old for basedpyright.
        -- `mason = false` makes LazyVim enable the binary already on PATH.
        basedpyright = { mason = false },
      },
    },
  },
}
