return {
  -- Live browser preview for HTML / Markdown / AsciiDoc.
  -- Pure Lua server (no node dependency) with built-in mermaid + katex.
  {
    "brianhuster/live-preview.nvim",
    dependencies = { "folke/snacks.nvim" },
    ft = { "html", "markdown", "asciidoc" },
    cmd = { "LivePreview" },
    opts = {
      port = 5500,
      autokill = false,
      browser = "default",
      dynamic_root = false,
      sync_scroll = true,
    },
    keys = {
      { "<leader>mp", "<cmd>LivePreview start<cr>", desc = "Live Preview (start)" },
      { "<leader>mx", "<cmd>LivePreview close<cr>", desc = "Live Preview (stop)" },
    },
  },
}
