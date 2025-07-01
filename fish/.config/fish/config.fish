if status is-interactive
    # Commands to run in interactive sessions can go here
    # eval (zellij setup --generate-auto-start fish | string collect)
end
set -gx EDITOR nvim
starship init fish | source
source $HOME/.config/fish/conf.d/abbr.fish
fish_ssh_agent
# set -gx JAVA_HOME ~/Documents/jdk1.8.0_381/
set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk

# pyenv init - fish | source

# pnpm
set -gx PNPM_HOME "/home/luisca/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Created by `pipx` on 2025-03-21 00:37:17
set PATH $PATH /home/luisca/.local/bin

# abbreviations
abbr -a mnvim NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim
abbr -a mvnim NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim
abbr -a mvim NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim
abbr -a mivm NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim
# Zenta aliases
abbr -a breath  'zenta now --quick'
abbr -a breathe 'zenta now'
abbr -a reflect 'zenta reflect'

# zellij
# Automatically start or attach to a default Zellij session
# when launching a new terminal.
function zj-default
  set default_session_name "term"

  if set -q ZELLIJ; or not status is-interactive
      return
  end
   
  # Check if the default session exists.
  if zellij list-sessions | grep -q "$default_session_name"
      exec zellij attach "$default_session_name"
  else
      exec zellij --session "$default_session_name"
  end
end
zj-default
