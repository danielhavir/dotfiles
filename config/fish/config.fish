source $HOME/.config/fish/aliases.fish

# Fish prompt/color config {{{

function fish_prompt
  set_color green --bold
  printf '%s@%s' (whoami) (hostname -s)
  set_color normal
  printf ':'

  set_color blue --bold
  printf '%s' (echo $PWD | sed -e "s|^$HOME|~|")
  set_color normal

  git_prompt

  set_color magenta
  printf ' $ '
  set_color normal
end

function git_current_branch -d 'Prints a human-readable representation of the current branch'
  set -l ref (git symbolic-ref HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
  if test -n "$ref"
    echo $ref | sed -e s,refs/heads/,,
    return 0
  end
end

function git_prompt
  if git rev-parse --show-toplevel >/dev/null 2>&1
    set_color yellow
    printf ' ('
    printf '%s)' (git_current_branch)
    set_color normal
  end
end

function fish_greeting
    echo
    echo -e (uname -rs | awk '{print " \\\\e[1mOS: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (uptime | sed 's/^up //' | awk '{print " \\\\e[1mUptime: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo -e (uname -n | awk '{print " \\\\e[1mHostname: \\\\e[0;32m"$0"\\\\e[0m"}')
    echo
    echo "Greetings, emperor!"
    set_color normal
end
