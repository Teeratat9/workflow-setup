# workflow-setup

My Neovim + terminal setup on macOS (Apple Silicon).
Neovim runs [LazyVim](https://www.lazyvim.org/); the prompt is
[oh-my-posh](https://ohmyposh.dev/) on zsh.

Full keymap and workflow reference: **[`nvim/docs/guide.html`](nvim/docs/guide.html)**
— download it and open in a browser, or from inside Neovim press `<leader>mp`.

## What you get

- LazyVim 16 with LSP, formatting and linting for TypeScript/React, Python,
  Tailwind, JSON, YAML and Markdown
- ` ```mermaid ` diagrams rendered as images **inside the terminal**
- Live browser preview for HTML and Markdown, with reload on save
- Git review in three layers: inline hunks, lazygit, and full side-by-side diffs
- A zsh startup that stays under ~0.3 s

## Layout

| path | what |
| --- | --- |
| `nvim/` | Neovim config — symlinked to `~/.config/nvim` |
| `nvim/docs/guide.html` | keymap + workflow guide, generated from this install |
| `kitty/` | kitty terminal config — symlinked to `~/.config/kitty` |
| `.poshthemes/` | oh-my-posh theme collection — copied to `~/.poshthemes` |
| `kitty_bak/`, `nvim_bak/` | older configs kept for reference; nothing reads them |

---

# Setup

Written for a fresh macOS machine. Every step is required unless marked
optional.

## 0. Prerequisites

Install [Homebrew](https://brew.sh/), which brings `git` with it:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then clone this repo. The symlinks later assume `~/workflow-setup`:

```sh
git clone https://github.com/Teeratat9/workflow-setup.git ~/workflow-setup
```

## 1. Packages

```sh
brew install neovim fd ripgrep fzf eza lazygit imagemagick mermaid-cli pyenv
brew install --cask font-meslo-lg-nerd-font
```

| package | needed by |
| --- | --- |
| `neovim` | the editor itself — 0.11 or newer |
| `fd`, `ripgrep` | LazyVim's file and grep pickers |
| `fzf` | fuzzy matching |
| `eza` | the `ls` / `ll` aliases below |
| `lazygit` | `<leader>gg` |
| `imagemagick` | `snacks.image` — converts non-PNG images |
| `mermaid-cli` | renders ` ```mermaid ` blocks to PNG |
| `pyenv` | Python version management |
| `font-meslo-lg-nerd-font` | **required** — LazyVim's icons are Nerd Font glyphs |

After installing the font, set it as your terminal's font, otherwise every
icon in the file explorer and statusline shows as a blank box.

Optional, depending on what you use:

```sh
brew install --cask warp          # or kitty, if you want the kitty/ config
brew install --cask google-chrome # see the mermaid note at the bottom
```

## 2. zsh

Install [oh-my-zsh](https://ohmyz.sh/), then the two plugins it does not bundle:

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

Install oh-my-posh:

```sh
brew install oh-my-posh
```

In `~/.zshrc`:

```sh
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
eval "$(oh-my-posh --init --shell zsh --config ~/.poshthemes/atomic.omp.json)"

alias ls="eza --icons --color=always --group-directories-first"
alias ll="eza -lah --icons --color=always --group-directories-first"
```

Three things that matter here:

- **Use exactly one prompt engine.** oh-my-posh and powerlevel10k both write
  `PROMPT`. Running p10k's instant-prompt alongside oh-my-posh gives you broken
  powerline glyphs and a cursor in the wrong place. If `~/.p10k.zsh` exists,
  it is not wanted here.
- **Let oh-my-zsh run `compinit`.** Add extra `fpath` entries *before*
  `source $ZSH/oh-my-zsh.sh` instead of calling `compinit` a second time —
  a duplicate call re-dumps the completion cache on every new shell.
- **Lazy-load nvm.** Sourcing `nvm.sh` eagerly costs roughly 400 ms per shell.
  Define `nvm`, `node`, `npm` and `npx` as stub functions that source it on
  first call.

## 3. Symlinks

```sh
mkdir -p ~/.config
ln -sfn ~/workflow-setup/nvim  ~/.config/nvim
ln -sfn ~/workflow-setup/kitty ~/.config/kitty   # only if you use kitty
cp -R   ~/workflow-setup/.poshthemes ~/.poshthemes
```

## 4. Python

The global interpreter must be reasonably modern — Mason builds a venv from
whatever `python3` resolves to, and anything older than 3.8 fails outright.

```sh
pyenv install 3.13.7
pyenv global 3.13.7
```

Add pyenv to `~/.zshrc` if you have not already:

```sh
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
```

The Python LSP is installed with [uv](https://docs.astral.sh/uv/) rather than
Mason, so it carries its own interpreter and keeps working no matter what
pyenv is set to:

```sh
brew install uv
uv tool install basedpyright
```

## 5. Node

Install [nvm](https://github.com/nvm-sh/nvm) and a current Node release. The
TypeScript LSP (`vtsls`), `prettier`, and several Mason packages are npm-based.

```sh
nvm install --lts
nvm alias default lts/*
```

## 6. Neovim

Launch `nvim` and let lazy.nvim bootstrap. Plugin versions come from
`nvim/lazy-lock.json`; LSP servers and formatters install through Mason the
first time you open each filetype. Then check nothing is broken:

```
:checkhealth
```

Two warnings are expected and harmless: `luarocks` not installed (LazyVim
says itself that nothing needs it), and `nvim-treesitter` having no
healthcheck on its current branch.

---

## Enabled LazyVim extras

`typescript`, `python`, `tailwind`, `json`, `yaml`, `markdown`,
`formatting.prettier` — recorded in `nvim/lazyvim.json`.

Add or remove them with `:LazyExtras` rather than editing that file by hand.

## Local plugin specs

| file | why it exists |
| --- | --- |
| `nvim/lua/plugins/python.lua` | enables basedpyright from `PATH` (`mason = false`) |
| `nvim/lua/plugins/image.lua` | `snacks.image` with `force = true`, see below |
| `nvim/lua/plugins/preview.lua` | live browser preview for HTML/Markdown |
| `nvim/lua/plugins/git.lua` | diffview, gitgraph, `git log --graph` keymaps |
| `nvim/lua/plugins/treesitter.lua` | adds css, scss, vue parsers |

## Notes

**Inline images need a terminal that supports them.** kitty, Ghostty, WezTerm
and Warp all implement the kitty graphics protocol. Warp does not *identify*
itself as any of them, so `snacks.image` auto-detection misses it — hence
`force = true` in `image.lua`. On a terminal that genuinely cannot display
images, drop that line and use the browser preview instead. Warp also discards
image escape sequences emitted *during shell init*; anything launched after
the prompt appears is fine.

**mermaid-cli needs a browser.** Homebrew's `mermaid-cli` does not bundle
Chromium, so `mmdc` cannot launch one on its own.
`nvim/lua/config/options.lua` points `PUPPETEER_EXECUTABLE_PATH` at Google
Chrome in `/Applications`. Change that path if your browser lives elsewhere.

**LazyVim 16 swapped several plugins.** The picker and file explorer are
`snacks.nvim`, not Telescope and neo-tree; completion is `blink.cmp`, not
nvim-cmp. Older tutorials and config snippets written for those plugins will
not apply here, though the `<leader>` keymaps are unchanged.

## Not tracked in this repo

These live on the machine:

- `~/.zshrc`
- pyenv versions and which one is global
- `uv tool` installs
- Homebrew packages
- Mason packages under `~/.local/share/nvim/mason`

The steps above are the record for rebuilding them.

<details>
<summary>My own global pip packages (skip this — it is not part of the setup)</summary>

Scripts of mine that are not pinned by a `.python-version` expect these on the
global interpreter:

```sh
pip install openpyxl python-docx lxml XlsxWriter python-dotenv \
            pytz python-dateutil six pandas xlwings
```

</details>
