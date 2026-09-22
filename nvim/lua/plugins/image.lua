return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        enabled = true,
        -- Warp implements the kitty graphics protocol but does not announce
        -- itself as kitty/ghostty/wezterm, so snacks' auto-detection misses it.
        -- `force` skips detection and emits the protocol anyway.
        force = true,
        doc = {
          enabled = true,
          inline = true, -- render inline, in place of the code block
          float = true, -- also allow the floating preview
        },
        convert = {
          notify = true, -- surface mmdc/magick failures instead of silently blank
        },
      },
    },
  },
}
