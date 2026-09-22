# workflow-setup

Dotfiles for my Neovim + terminal setup on macOS (Apple Silicon).
Neovim runs [LazyVim](https://www.lazyvim.org/); the prompt is oh-my-posh on zsh.

Full keymap and workflow reference: **[`nvim/docs/guide.html`](nvim/docs/guide.html)**
(open it in a browser, or from inside Neovim with `<leader>mp`).

## Layout

| path | what |
| --- | --- |
| `nvim/` | Neovim config — symlinked to `~/.config/nvim` |
| `nvim/docs/guide.html` | keymap + workflow guide, generated from this install |
| `kitty/` | kitty terminal config — symlinked to `~/.config/kitty` |
| `.poshthemes/` | oh-my-posh themes — copied to `~/.poshthemes` |
| `kitty_bak/`, `nvim_bak/` | old configs kept for reference; not used by anything |

## Bootstrap on a new machine

### 1. Homebrew packages

```sh
brew install fd ripgrep fzf eza lazygit imagemagick mermaid-cli
```

| package | needed by |
| --- | --- |
| `fd`, `ripgrep` | LazyVim file/grep pickers |
| `fzf` | fuzzy matching |
| `eza` | the `ls` / `ll` aliases |
| `lazygit` | `<leader>gg` |
| `imagemagick` | `snacks.image` — converts non-PNG images |
| `mermaid-cli` | renders ` ```mermaid ` blocks to PNG |

### 2. zsh

Install [oh-my-zsh](https://ohmyz.sh/), then the two plugins it does not bundle:

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

In `~/.zshrc`:

```sh
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
eval "$(oh-my-posh --init --shell zsh --config ~/.poshthemes/atomic.omp.json)"
```

Use **exactly one** prompt engine. oh-my-posh and powerlevel10k both write
`PROMPT`, and running p10k's instant-prompt alongside oh-my-posh produces
broken powerline glyphs and a misplaced cursor. If `~/.p10k.zsh` exists,
it is not wanted here.

Two things that keep startup fast:

- Let oh-my-zsh run `compinit`. Add any extra `fpath` entries *before*
  `source $ZSH/oh-my-zsh.sh` rather than calling `compinit` a second time —
  a duplicate call re-dumps the completion cache on every shell.
- Lazy-load nvm. Sourcing `nvm.sh` eagerly costs ~400 ms per shell.

### 3. Symlinks

```sh
ln -sfn ~/workflow-setup/nvim  ~/.config/nvim
ln -sfn ~/workflow-setup/kitty ~/.config/kitty
cp -R ~/workflow-setup/.poshthemes ~/.poshthemes
```

### 4. Python

pyenv's global must be a modern Python — Mason installs several tools into a
venv built from whatever `python3` resolves to, and anything older than 3.8
fails outright.

```sh
pyenv install 3.13.7
pyenv global 3.13.7
```

Packages the global interpreter is expected to have, for scripts under `~/Dev`
that are not pinned by a `.python-version`:

```sh
pip install openpyxl python-docx lxml XlsxWriter python-dotenv \
            pytz python-dateutil six pandas xlwings
```

The Python LSP is installed with uv rather than Mason, so it carries its own
interpreter and keeps working no matter what pyenv is set to:

```sh
uv tool install basedpyright
```

### 5. Node

Install [nvm](https://github.com/nvm-sh/nvm) and a current Node. The
TypeScript LSP (`vtsls`), `prettier`, and several Mason packages are npm-based.

### 6. Neovim

Launch `nvim` and let lazy.nvim bootstrap. Plugins come from
`nvim/lazy-lock.json`; LSP servers and formatters install through Mason on
first use of each filetype. Then:

```
:checkhealth
```

## Enabled LazyVim extras

`typescript`, `python`, `tailwind`, `json`, `yaml`, `markdown`,
`formatting.prettier` — see `nvim/lazyvim.json`.

Add or remove them with `:LazyExtras` rather than by hand.

## Local plugin specs

| file | why it exists |
| --- | --- |
| `nvim/lua/plugins/python.lua` | enables basedpyright from PATH (`mason = false`) |
| `nvim/lua/plugins/image.lua` | `snacks.image` with `force = true` for Warp |
| `nvim/lua/plugins/preview.lua` | live browser preview for HTML/Markdown |
| `nvim/lua/plugins/git.lua` | diffview, gitgraph, `git log --graph` keymaps |
| `nvim/lua/plugins/treesitter.lua` | adds css, scss, vue parsers |

## Notes

**Warp and inline images.** Warp implements the kitty graphics protocol but
does not identify itself as kitty, ghostty, or wezterm, so `snacks.image`
auto-detection misses it. `force = true` in `image.lua` skips detection.
Warp also drops image escape sequences emitted *during shell init*; anything
started after the prompt appears is fine.

**mermaid-cli and Chrome.** Homebrew's `mermaid-cli` does not bundle Chromium,
so `mmdc` cannot launch a browser on its own.
`nvim/lua/config/options.lua` points `PUPPETEER_EXECUTABLE_PATH` at the
installed Google Chrome. On a machine without Chrome, install a browser for
puppeteer or change that path.

**LazyVim 16 swapped several plugins.** The picker and file explorer are
`snacks.nvim`, not Telescope and neo-tree; completion is `blink.cmp`, not
nvim-cmp. Older tutorials and config snippets for those plugins will not
apply, though the `<leader>` keymaps are unchanged.

## Not tracked here

These live on the machine, not in this repo:

- `~/.zshrc`
- pyenv versions and the global selection
- `uv tool` installs
- Homebrew packages
- Mason packages under `~/.local/share/nvim/mason`

Section 4 above is the record for the Python side; the rest is reinstalled
with the commands in this file.
