  # The list of segments shown on the left. Fill it with the most important segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    os_icon                 # os identifier
    dir                     # current directory
    vcs                     # git status
    # =========================[ Line #2 ]=========================
    newline                 # \n
    # =========================[ Line #3 ]=========================
    newline                 # \n
    prompt_char             # prompt symbol
  )

  # The list of segments shown on the right. Fill it with less important segments.
  # Right prompt on the last prompt line (where you are typing your commands) gets
  # automatically hidden when the input line reaches it. Right prompt above the
  # last prompt line gets hidden if it would overlap with left prompt.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    # =========================[ Line #1 ]=========================
    #core
    #code
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    direnv                  # direnv status (https://direnv.net/)
    asdf                    # asdf version manager (https://github.com/asdf-vm/asdf)
    virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    # anaconda                # conda environment (https://conda.io/)
    pyenv                   # python environment (https://github.com/pyenv/pyenv)
    goenv                   # go environment (https://github.com/syndbg/goenv)
    nodenv                  # node.js version from nodenv (https://github.com/nodenv/nodenv)
    nvm                     # node.js version from nvm (https://github.com/nvm-sh/nvm)
    nodeenv                 # node.js environment (https://github.com/ekalinin/nodeenv)
    # node_version          # node.js version
    # go_version            # go version (https://golang.org)
    # rust_version          # rustc version (https://www.rust-lang.org)
    # dotnet_version        # .NET version (https://dotnet.microsoft.com)
    # php_version           # php version (https://www.php.net/)
    # laravel_version       # laravel php framework version (https://laravel.com/)
    # java_version          # java version (https://www.java.com/)
    # package               # name@version from package.json (https://docs.npmjs.com/files/package.json)
    rbenv                   # ruby version from rbenv (https://github.com/rbenv/rbenv)
    rvm                     # ruby version from rvm (https://rvm.io)
    fvm                     # flutter version management (https://github.com/leoafarias/fvm)
    luaenv                  # lua version from luaenv (https://github.com/cehoffman/luaenv)
    jenv                    # java version from jenv (https://github.com/jenv/jenv)
    plenv                   # perl version from plenv (https://github.com/tokuhirom/plenv)
    phpenv                  # php version from phpenv (https://github.com/phpenv/phpenv)
    scalaenv                # scala version from scalaenv (https://github.com/scalaenv/scalaenv)
    haskell_stack           # haskell version from stack (https://haskellstack.org/)
    kubecontext             # current kubernetes context (https://kubernetes.io/)
    terraform               # terraform workspace (https://www.terraform.io)
    aws                     # aws profile (https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
    aws_eb_env              # aws elastic beanstalk environment (https://aws.amazon.com/elasticbeanstalk/)
    azure                   # azure account name (https://docs.microsoft.com/en-us/cli/azure)
    gcloud                  # google cloud cli account and project (https://cloud.google.com/)
    google_app_cred         # google application credentials (https://cloud.google.com/docs/authentication/production)
    context                 # user@hostname
    nordvpn                 # nordvpn connection status, linux only (https://nordvpn.com/)
    ranger                  # ranger shell (https://github.com/ranger/ranger)
    nnn                     # nnn shell (https://github.com/jarun/nnn)
    vim_shell               # vim shell indicator (:sh)
    midnight_commander      # midnight commander shell (https://midnight-commander.org/)
    nix_shell               # nix shell (https://nixos.org/nixos/nix-pills/developing-with-nix-shell.html)
    # vi_mode               # vi mode (you don't need this if you've enabled prompt_char)
    vpn_ip                # virtual private network indicator
    uptime
    todo                    # todo items (https://github.com/todotxt/todo.txt-cli)
    timewarrior             # timewarrior tracking status (https://timewarrior.net/)
    taskwarrior             # taskwarrior task count (https://taskwarrior.org/)
    time                    # current time
    # =========================[ Line #2 ]=========================
    newline                 # \n
    healthcheck             # healthcheck score
    load                  # CPU load
    disk_usage            # disk usage
    ram                   # free RAM
    swap                  # used swap
    # =========================[ Line #3 ]=========================
    newline                 # \n
    # ip                    # ip address and bandwidth usage for a specified network interface
    # public_ip             # public IP address
    proxy                 # system-wide http/https/ftp proxy
    battery               # internal battery
    # wifi                  # wifi speed
    # update
    cpu
    # example               # example user-defined segment (see prompt_example function below)
  )

  # Example of a user-defined prompt segment. Function prompt_example will be called on every
  # prompt if `example` prompt segment is added to POWERLEVEL9K_LEFT_PROMPT_ELEMENTS or
  # POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS. It displays an icon and orange text greeting the user.
  #
  # Type `p10k help segment` for documentation and a more sophisticated example.

  function prompt_example() {
    p10k segment -f 208 -i '⭐' -t 'hello, %n'
  }

  function prompt_update() {
    updates=$(cat /tmp/update-available)
    if [ -n "$updates" ]
    then
      if [ "$updates" -eq "1" ]
      then
        p10k segment -f 208 -i '↑' -t "$updates update is available"
      #fi
      elif (( $updates > 1 ))
      then
        p10k segment -f 208 -i '↑' -t "$updates updates are available"
      fi
    fi
  }

  prompt_code() {
    # echo $?
    if (( $? > 0 ))
    then
      p10k segment -i '✘' -t $? -f "red"
    fi
  }

  function prompt_core() {
    local size=()
    if ! zstat -A size +size ./ 2>/dev/null; then
      return
    fi
    if [[ -w . ]]; then
      local state=DELETABLE
    else
      local state=PROTECTED
    fi
    p10k segment -s $state -f yellow -t ${size[1]}b
  }

  function prompt_cpu() {
  	integer cpu_temp="$(</sys/class/thermal/thermal_zone0/temp) / 1000"
	  if (( cpu_temp >= 95 )); then
	    p10k segment -s HOT -f red -i '🔥' -t "${cpu_temp}°C"
	  elif (( cpu_temp >= 80 )); then
	    p10k segment -s WARM -f yellow -i '🌡' -t "${cpu_temp}°C"
	  fi
  }

  function prompt_uptime() {
    uptime="$(uptime -p | sed 's/[^ ]*//' | cut -c2-)"
    p10k segment -f 248 -i '⧗' -t "$uptime"
  }

  function prompt_healthcheck() {
  	local health_score="$(echo $(dbus-send --session --print-reply --dest=org.healthcheck /org/healthcheck org.healthcheck.Score.get_score 2>/dev/null || echo '-1') | tail -n 1 | awk '{print $NF}')"
    # If health score is -1, then healthcheck is not running, so don't show anything
    if (( health_score == -1 )); then
      return
    fi
    # The health score is a number between 0 and 100 (100 being the best), so
    # we can use it to determine the color of the segment
    # In normal use, the score is between 60 and 80, so we'll use that as the
    # threshold for the colors
    if (( health_score >= 80 )); then
      p10k segment -s HEALTHY -f green -i '🏥' -t "${health_score}"
    elif (( health_score >= 60 )); then
      p10k segment -s OK -f 248 -i '🏥' -t "${health_score}"
    elif (( health_score >= 40 )); then
      p10k segment -s WARNING -f yellow -i '🏥' -t "${health_score}"
    elif (( health_score >= 20 )); then
      p10k segment -s DANGER -f red -i '🏥' -t "${health_score}"
    else
      p10k segment -s CRITICAL -f red -i '🏥' -t "${health_score}"
    fi
  }

  # User-defined prompt segments may optionally provide an instant_prompt_* function. Its job
  # is to generate the prompt segment for display in instant prompt. See
  # https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
  #
  # Powerlevel10k will call instant_prompt_* at the same time as the regular prompt_* function
  # and will record all `p10k segment` calls it makes. When displaying instant prompt, Powerlevel10k
  # will replay these calls without actually calling instant_prompt_*. It is imperative that
  # instant_prompt_* always makes the same `p10k segment` calls regardless of environment. If this
  # rule is not observed, the content of instant prompt will be incorrect.
  #
  # Usually, you should either not define instant_prompt_* or simply call prompt_* from it. If
  # instant_prompt_* is not defined for a segment, the segment won't be shown in instant prompt.
  function instant_prompt_example() {
    # Since prompt_example always makes the same `p10k segment` calls, we can call it from
    # instant_prompt_example. This will give us the same `example` prompt segment in the instant
    # and regular prompts.
    prompt_example
  }

  function instant_prompt_update() {
    prompt_update
  }

  function instant_prompt_code() {
    prompt_code
  }

  function instant_prompt_cpu() {
    prompt_cpu
  }

  function instant_prompt_healthcheck() {
    prompt_healthcheck
  }

  # User-defined prompt segments can be customized the same way as built-in segments.
  typeset -g POWERLEVEL9K_EXAMPLE_FOREGROUND=208
  typeset -g POWERLEVEL9K_EXAMPLE_VISUAL_IDENTIFIER_EXPANSION='⭐'
