set source_files \
  "$HOME/.config/fish/aliases.fish" \
  "$HOME/.config/fish/kubernetes-helpers.fish" \
  "$HOME/.config/fish/private.fish" \
  "$HOME/google-cloud-sdk/path.fish.inc"

for file in $source_files
  if test -e "$file"
    source "$file"
  end
end

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

function find_container_id
    set container_name_part $argv[1]
    docker ps -a --filter "name=$container_name_part" --format "{{.ID}} {{.Names}}" | grep "$container_name_part" | head -n 1 | awk '{print $1}'
end

function find_image_id
    set image_name_part $argv[1]
    docker image ls --format "{{.ID}} {{.Repository}}" | grep "$image_name_part" | awk '{print $1}'
end

function source_env
    set -l env_file $argv[1]
    if test -z "$env_file"
        set env_file ".env"
    end

    for line in (cat $env_file)
        # Check if the line is commented out
        set -l first_char (string sub -l 1 -- $line)
        if test "$first_char" = "#"
            continue
        end

        # Split line into key and value
        set -l key (echo $line | cut -d= -f1)
        set -l value (echo $line | cut -d= -f2-)

        # Remove any spaces around key and value
        set key (string trim $key)
        set value (string trim $value)

        # Handle export of the variable to global environment
        set -gx $key $value
    end
end

