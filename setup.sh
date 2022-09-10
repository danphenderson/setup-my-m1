# After initial user setup install Xcode from the Apple App Store.
# Execute shell commands sequentially, with interruption from the
# occasional 'MANUAL' instruction.


# Install homebrew at /opt/homebrew/bin/brew.
# Prompts for password to install xcode command line tools
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"



# Intall roseta mode to expose x86 ISA arch to clone a roseta terminal
softwareupdate --install-roseta
# MANUAL: Install docker on M1 silicon
# https://docs.docker.com/desktop/mac/apple-silicon/



# Github setup
# MANUAL: modify git config shell cmds
brew install git
git config --global user.name "<username>"
git config --global user.name "<github-email>"
git config --global init.defaultBranch "<main or master>"



# MANUAL: generate a ssh key associated with github email
# and the id_rsa.pub key in yoiur github settings.
brew install openssh
cd ~ && mkdir .ssh && cd .ssh
ssh-keygen -t rsa -b 4096 -C "<github-email>"
cd ~



# Julia Insall
brew install --cask julia



# Python Install
brew install python@3.10
brew install pipenv



# Install minforge https://conda-forge.org/docs/user/introduction.html
# Containing ARM64 builds of many annoconda sdists.
brew install miniforge



# Pyspark
# https://sparkbyexamples.com/pyspark/how-to-install-pyspark-on-mac/#google_vignette
brew install openjdk@11
brew install scala
brew install apache-spark



# Nodejs
brew install nodejs



# Postqresql
brew install postgresql@14 freetds openssl



# Setup iterm2, using modern zsh build.
# MANUAL: Open 'iterm' in ~/Applications.
brew install zsh
brew install --cask iterm2


# Setup oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/powerline/fonts.git --depth=1 
cd fonts
./install.sh
cd ..
rm -rf fonts
echo '
local dir_color=130
local input_color=220
error_msg="\e[0;31mCommand failed"
PROMPT="$FG[${dir_color}]%.$FG[${input_color}] > "
preexec()
{
  echo -ne "\e[0m"
}
# Printing error message if command failed.
precmd()
{
  # Command failed
  if [ $? -ne 0 ];
  then
    echo "${error_msg}"
  fi
}
' >> $ZSH/custom/simple.zsh-theme



echo '
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="simple"
ZSH_CUSTOM="$ZSH/custom"
ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="vim"
fi

# Aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias python="python3"

# System
export LANG=en_US.UTF-8

# Python
export PIPENV_VENV_IN_PROJECT=true

## JULIA
export JULIA_NUM_THREADS=10

# Pyspark
export PYSPARK_DRIVER_PYTHON="ipython"
export PYSPARK_SUBMIT_ARGS="--master local[10] pyspark-shell"

# Postqresql
export LDFLAGS="-L/opt/homebrew/opt/freetds/lib -L/opt/homebrew/opt/openssl@3/lib"
export CFLAGS="-I/opt/homebrew/opt/freetds/include"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
' >> ~/.zshrc



source ~/.zshrc