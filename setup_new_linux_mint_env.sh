#!/usr/bin/env bash
# Author: Farman Ulhaq
# Date:   4/18/2019
# Description: This script installs all necessary software I need to Linux
    ##Step: Install Fish Shell
    #Step: Install Git
    #Step: Install plank
    #Step: Configure Common Git Aliases
    #Step: Install ranger - a vim inspired file manager
    #Step: Install Terminator - terminal
    #Step: Install docker.io
    #Step: Install dotnet core 2.2
    #Step: Install VIM
    #Step: Install The Ultimate vimrc
    #Step: Install vim athena
    #Step: Install GCloud
    #Step: Install Kubectl
    #Step: Install Kubectx and kubens
    #Step: Install Kubebox
    #Step: Kubectx and Kubens Autocomplete & Alias - Fish Shell
    #Step: Install Helm
    #Step: Install jq
    #Step: Install snap
    #Step: Install fluxctl
    #Step: Install popeye
    #Step: Install pbcopy and pbpaste
    #Step: Install Parcellite
    #Step: Install Shutter
    #Step: Installl Remmina for RDP
    #Step: Install npm
    #Step: Install Oh My Fish - Fish Shell Customizer
    #Step: Install Powerline Fonts
    #Step: Default to bobthefish terminal theme
    #Step: Kubectl Autocomplete & Alias - Fish Shell
    #Step: Install Fisher
    #Step: Install z - Jump Around for Fish Shell
#NOTE: For Laptops, install this tool to get brightness working: https://github.com/Redsandro/thinkpad-x1-yoga



# Helper Functions
: ${USE_SUDO:="true"}
runAsRoot() {
  local CMD="$*"

  if [ $USE_SUDO = "true" ]; then
    CMD="sudo $CMD"
  fi

  $CMD
}

RED='\033[0,31m'
NC='\033[0m' # No Color

##Step: Install Fish Shell
#Ref:  https://fishshell.com/
echo 'Installing Fish'
runAsRoot apt-get install fish -y
runAsRoot chsh -s /usr/bin/fish

#Step: Install Git
#Ref:  https://git-scm.com/downloads
echo "Installing Git"
runAsRoot apt-get install git -y

#Step: Install AntiMicro
#Ref: http://linuxg.net/how-to-install-antimicro-on-ubuntu-18-10-and-ubuntu-18-04/
echo "Installing AntiMicro"
runAsRoot apt install gdebi
wget https://launchpad.net/~mdeguzis/+archive/ubuntu/libregeek/+files/antimicro_2.23~artful-1_i386.deb
runAsRoot sudo gdebi antimicro*.deb

#Step: Install plank
#Ref: https://www.reddit.com/r/linuxmint/comments/czfuyy/former_windowsuser_switched_to_linux_mint_never/
#Ref: https://www.gnome-look.org/p/1275087/
echo "Installing plank"
runAsRoot apt-get install plank -y
cp plank.desktop ~/.config/autostart/

#Step: Configure Common Git Aliases
#Ref:  https://haacked.com/archive/2014/07/28/github-flow-aliases/
echo 'Configuring common Git Aliases'
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.cob checkout -b

#Step: Install ranger - a vim inspired file manager
#Ref: https://github.com/ranger/ranger
runAsRoot apt-get install ranger -y

#Step: Install Terminator - terminal
#Ref: https://terminator-gtk3.readthedocs.io/en/latest/gettingstarted.html
runAsRoot apt-get install terminator -y
#Change default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/terminator
gsettings set org.gnome.desktop.default-applications.terminal exec-arg "-x"
gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/terminator

#Step: Install docker.io
#Ref:
runAsRoot apt-get install docker.io -y
runAsRoot groupadd docker
runAsRoot usermod -aG docker $USER

#Step: Install dotnet core 2.2
Site: https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-10/sdk-current
echo 'Installing dotnet core 2.2'
wget -q https://packages.microsoft.com/config/ubuntu/18.10/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get install apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-2.2
sudo dpkg --purge packages-microsoft-prod && sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-2.2



#Step: Install VIM
#Ref:  https://www.vim.org/download.php
echo -e "${RED}Installing VIM${NC}"
runAsRoot apt-get install vim -y

#Step: Install The Ultimate vimrc
#Ref:  https://github.com/amix/vimrc
echo 'Installing The Ultimate vimrc'
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

#Step: Install vim athena
#Ref:  https://askubuntu.com/questions/60200/how-to-copy-data-between-different-instances-of-vim
echo 'Installing vim-athena'
runAsRoot apt-get install -y vim-athena

#Step: Install GCloud
#Ref:  https://cloud.google.com/sdk/install
echo 'Installing GCloud'
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
runAsRoot apt-get install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
runAsRoot apt-get update -y
runAsRoot apt-get install -y google-cloud-sdk


#Step: Install Kubectl
#Ref:  https://kubernetes.io/docs/tasks/tools/install-kubectl/
#Ref:
#NOTE: Give you've installed GCloud above, you can install kubectl with apt without any fancy script
echo 'Installing Kubectl'
runAsRoot apt-get install -y kubectl



#Step: Install Kubectx and kubens
#Ref:  https://github.com/ahmetb/kubectx
echo 'Installing Kubectx and Kubens'
runAsRoot git clone https://github.com/ahmetb/kubectx /opt/kubectx
runAsRoot ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
runAsRoot ln -s /opt/kubectx/kubens /usr/local/bin/kubens

#Step: Install Kubebox
#Ref: https://github.com/astefanutti/kubebox
echo 'Installing Kubebox'
releaseURL='https://github.com/astefanutti/kubebox/releases/download/vRELEASENAME/kubebox-linux'
release=$(curl -s https://api.github.com/repos/astefanutti/kubebox/releases | jq -r '.[0].tag_name' | awk '{print substr($1,2);   }')
newURL="${releaseURL//RELEASENAME/$release}"
runAsRoot curl -Lo /opt/kubebox https://github.com/astefanutti/kubebox/releases/download/v0.6.0/kubebox-linux
runAsRoot chmod +x /opt/kubebox
runAsRoot ln -s /opt/kubebox /usr/local/bin/kubebox


#Step: Kubectx and Kubens Autocomplete & Alias - Fish Shell
#Ref:  https://github.com/ahmetb/kubectx/tree/master/completion
echo 'Kubectx and Kubens Autocomplete & Alias - Fish Shell'
mkdir -p ~/.config/fish/completions
ln -s /opt/kubectx/completion/kubectx.fish ~/.config/fish/completions/
ln -s /opt/kubectx/completion/kubens.fish ~/.config/fish/completions/
cp /opt/kubectx/completion/kubens.fish /opt/kubectx/completion/kn.fish
ln -s /opt/kubectx/completion/kn.fish ~/.config/fish/completions/kn.fish
ln -s /opt/kubectx/completion/kubectx.fish ~/.config/fish/completions/kc.fish
fish -c "alias kc=kubectx; funcsave kc"
fish -c "alias kn=kubens; funcsave kn"

#Step: Install Helm
#Ref:  https://helm.sh/docs/using_helm/#installing-helm
echo 'Installing Helm'
runAsRoot curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > /tmp/get_helm.sh
runAsRoot chmod 700 /tmp/get_helm.sh
runAsRoot /tmp/get_helm.sh
runAsRoot rm /tmp/get_helm.sh

#Step: Install jq
#Ref:  https://stedolan.github.io/jq/
echo 'Installing jq - json parsing'
runAsRoot apt-get install jq -y

#Step: Install snap
#Ref: https://docs.snapcraft.io/installing-snapd
runAsRoot apt-get install snapd -y

#Step: Install fluxctl
#Ref: https://www.weave.works/blog/install-fluxctl-and-manage-your-deployments-easily
runAsRoot snap install fluxctl

#Step: Install popeye
#Ref:  https://github.com/derailed/popeye
echo 'Installing popeye'
releaseURL='https://github.com/derailed/popeye/releases/download/vRELEASENAME/popeye_RELEASENAME_Linux_x86_64.tar.gz'
release=$(curl -s https://api.github.com/repos/derailed/popeye/releases | jq -r '.[0].tag_name' | awk '{print substr($1,2); }')
newURL="${releaseURL//RELEASENAME/$release}"
wget $newURL -O /tmp/popeye.tar.gz
runAsRoot mkdir /opt/popeye
runAsRoot tar -xf /tmp/popeye.tar.gz -C /opt/popeye
runAsRoot ln -s /opt/popeye/popeye /usr/local/bin/popeye

########### COOL UTILITIES ################
#Step: Install pbcopy and pbpaste
echo 'Installing pbcopy and pbpaste'
runAsRoot apt install xclip xsel
fish -c "alias pbcopy='xclip -selection clipboard'; funcsave pbcopy"
fish -c "alias pbpaste='xclip -selection clipboard -o'; funcsave pbpaste"


#Step: Install Parcellite
echo 'Installing Parcellite'
runAsRoot apt-get install parcellite -y

#Step: Install Shutter
echo 'Installing Shutter'
runAsRoot apt-get install shutter -y

#Step: Installl Remmina for RDP
echo 'Installing Remmina for RDP'
runAsRoot apt-add-repository ppa:remmina-ppa-team/remmina-next -y
runAsRoot apt-get update -y
runAsRoot apt-get install -y remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice
runAsRoot killall remmina

#Step: Install npm
echo 'Installing npm'
runAsRoot apt-get install npm -y

############# FISH SHELL RELATED STUFF ######################
#Step: Install Oh My Fish - Fish Shell Customizer
#Ref: https://www.ostechnix.com/oh-fish-make-shell-beautiful/
#Ref: https://github.com/oh-my-fish
curl -L https://get.oh-my.fish | fish
fish -c "omf install weather"
# Add alias for outside temprature
alias outside="weather new york"
funcsave outside
#Step: Install Powerline Fonts
#Ref: https://github.com/powerline/fonts
runAsRoot apt-get install fonts-powerline -y


#Step: Default to bobthefish terminal theme
#Ref: https://github.com/oh-my-fish/theme-bobthefish
omf install bobthefish
set -g theme_powerline_fonts no
# also recommended: -omf install taktoa

#Step: Kubectl Autocomplete & Alias - Fish Shell
#Ref:  https://github.com/evanlucas/fish-kubectl-completions
echo 'Kubectl  Autocomplete & Alias for Fish Shell'
mkdir -p ~/.config/fish/completions
git clone https://github.com/evanlucas/fish-kubectl-completions ~/.config/fish/fish-kubectl-completions
ln -s ~/.config/fish/fish-kubectl-completions/completions/kubectl.fish ~/.config/fish/completions/
ln -s ~/.config/fish/fish-kubectl-completions/completions/kubectl.fish ~/.config/fish/completions/k.fish  #**** handles  completion for the 'k' alias
fish -c "alias k=kubectl; funcsave k"
fish -c "alias kk='kubectl get pods'; funcsave kk"

#Step: Install Fisher
#Ref:  https://github.com/jorgebucaran/fisher
echo 'Installing Fisher'
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

#Step: Install z - Jump Around for Fish Shell
#Ref:  https://github.com/jethrokuan/z
echo 'Installing z - Directory Jumping'
fish -c "fisher add jethrokuan/z"


#Step: Startup redshift for blue light filter
#Ref:
cp redshift-gtk.desktop ~/.config/autostart/
