# workflow-setup
These are my work flow setup of neovim and kitty terminal

# Setup Step
1. Use zsh shell don't forgot to use zsh plugin autosuggest and highlight<br>``plugins=(	
  git
  zsh-syntax-highlighting
	zsh-autosuggestions
)``
2. Add this line to end of startup shell(.zshrc) file<br> ```eval "$(oh-my-posh --init --shell zsh --config ~/.poshthemes/atomic.omp.json)"``` 
3. Install oh-my-posh for terminal themes move `.oh-my-posh` to home directory 
4. move kitty and nvim to `~/.config/`
