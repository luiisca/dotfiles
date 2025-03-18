if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx EDITOR nvim
starship init fish | source
source $HOME/.config/fish/conf.d/abbr.fish
fish_ssh_agent
set -gx JAVA_HOME ~/Documents/jdk1.8.0_381/

pyenv init - fish | source

# pnpm
set -gx PNPM_HOME "/home/luisca/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
