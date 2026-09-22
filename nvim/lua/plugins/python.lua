return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- basedpyright comes from `uv tool install basedpyright`, which ships
        -- its own Python. `mason = false` makes LazyVim enable that binary from
        -- the PATH instead of waiting on a mason install.
        --
        -- Mason's pip installer would work now that pyenv's global is 3.13.7
        -- (it was pinned to 3.5.10, too old for basedpyright). Staying on uv
        -- keeps the LSP working regardless of what pyenv is set to later.
        basedpyright = { mason = false },
      },
    },
  },
}
