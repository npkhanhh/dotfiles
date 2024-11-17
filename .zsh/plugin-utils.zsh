function plugin-clone {
  local repo plugdir initfile initfiles=()
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.zsh}/plugins}
  for repo in $@; do
    plugdir=$ZPLUGINDIR/${repo:t}
    initfile=$plugdir/${repo:t}.plugin.zsh
    if [[ ! -d $plugdir ]]; then
      echo "Cloning $repo..."
      git clone -q --depth 1 --recursive --shallow-submodules \
        https://github.com/$repo $plugdir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugdir/*.{plugin.zsh,zsh-theme,zsh,sh}(N))
      (( $#initfiles )) && ln -sf $initfiles[1] $initfile
    fi
  done
}

# this sources them in the ORDER you want (as some plugins need a certain order to work in)
function plugin-source {
  local plugdir
  ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.zsh}/plugins}
  for plugdir in $@; do
    [[ $plugdir = /* ]] || plugdir=$ZPLUGINDIR/$plugdir
    fpath+=$plugdir
    local initfile=$plugdir/${plugdir:t}.plugin.zsh
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

# to update all of your plugins run this
function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.zsh/plugins}
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

# to get a list of your plugins
function plugin-list ()
{
  eza -la --icons $ZPLUGINDIR
}

# to remove a plugin
# rm -rfi $ZPLUGINDIR/<plugin-dir-name>

# repos to clone
repos=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
  MichaelAquilina/zsh-you-should-use
  wfxr/forgit
  sindresorhus/pure
  jonmosco/kube-ps1
)

# plugins to source
# ORDER MATTERS HERE!
plugins=(
  forgit
  # colored-man-pages
  zsh-you-should-use
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  pure
  kube-ps1
)

plugin-clone $repos
plugin-source $plugins
