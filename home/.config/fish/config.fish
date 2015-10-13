function fish_prompt --description 'Write out the prompt'
  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    # set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __git_cb
    set __git_cb ":"(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
  end

  switch $USER
    case root

    if not set -q __fish_prompt_cwd
      if set -q fish_color_cwd_root
          set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
      else
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end
    end

    printf '%s%s%s%s# ' $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    case '*'

    if not set -q __fish_prompt_cwd
      set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '%s%s%s%s$ ' $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb
  end
end

set -xU HOMEBREW_GITHUB_API_TOKEN 072305f77483902e6c7d3c85b2c635d1f66dac3f

# .envrc file 
eval (direnv hook fish)

# go package manager
function gvm
  bass source ~/.gvm/scripts/gvm ';' gvm $argv
end
gvm use go1.4.3

# ruby package manager
rvm default

# nvm package manager
test -s /Users/senthil/.nvm-fish/nvm.fish; and source /Users/senthil/.nvm-fish/nvm.fish
# nvm use v0.10.10

function rc
  git --work-tree=$HOME/ --git-dir=$HOME/dotfiles.git $argv
end

set -xU EDITOR /usr/local/bin/vim