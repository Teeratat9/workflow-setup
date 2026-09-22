-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Python: use basedpyright (installed via `uv tool install basedpyright`,
-- so it is independent of pyenv / the system python3).
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"

-- Show both absolute and relative line numbers (relative makes 5j / 12k easy to aim)
vim.opt.relativenumber = true
vim.opt.number = true

-- Keep a bit of context around the cursor when scrolling
vim.opt.scrolloff = 8

-- mermaid-cli (mmdc) is installed via Homebrew, which does not bundle Chromium.
-- Point puppeteer at the Chrome already on this machine so Snacks.image can
-- convert ```mermaid blocks to PNG.
vim.env.PUPPETEER_EXECUTABLE_PATH =
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
