#!/usr/bin/env bash
# Author: Farman Ulhaq
# Date:   4/18/2019
# Description: This script installs all necessary software I need to Linux
    #Step: Install Git
    #Step: Install VIM
    #Step: Install The Ultimate vimrc
    #Step: Install Fish Shell
    #Step: Install GCloud
    #Step: Install Kubectl
    #Step: Kubectl Autocomplete & Alias - Fish Shell
    #Step: Install Kubectx and kubens
    #Step: Kubectx and Kubens Autocomplete & Alias - Fish Shell
    #Step: Install Helm
    #Step: Install Fisher
    #Step: Install z
    #Step: Install jq
    #Step: Install popeye




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

#Step: Install Git
#Site: https://git-scm.com/downloads
echo "Installing Git"
runAsRoot apt-get install git -y

#Step: Install VIM
#Site: https://www.vim.org/download.php
echo -e "${RED}Installing VIM${NC}"
runAsRoot apt-get install vim -y

#Step: Install The Ultimate vimrc
#Site: https://github.com/amix/vimrc
echo 'Installing The Ultimate vimrc'
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

#Step: Install Fish Shell
#Site: https://fishshell.com/
echo 'Installing Fish'
runAsRoot apt-get install fish -y
runAsRoot chsh -s /usr/bin/fish

#Step: Install GCloud
#Site: https://cloud.google.com/sdk/install
echo 'Installing GCloud'
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
runAsRoot apt-get update -y
runAsRoot apt-get install google-cloud-sdk -y



#Step: Install Kubectl
#Site: https://kubernetes.io/docs/tasks/tools/install-kubectl/
#Site:
echo 'Installing Kubectl'
runAsRoot apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
runAsRoot apt-get update
runAsRoot apt-get install -y kubectl

#Step: Kubectl Autocomplete & Alias - Fish Shell
#Site: https://github.com/evanlucas/fish-kubectl-completions
echo 'Kubectl  Autocomplete & Alias for Fish Shell'
mkdir -p ~/.config/fish/completions
git clone https://github.com/evanlucas/fish-kubectl-completions ~/.config/fish/fish-kubectl-completions
ln -s ~/.config/fish/fish-kubectl-completions/completions/kubectl.fish ~/.config/fish/completions/
ln -s ~/.config/fish/fish-kubectl-completions/completions/kubectl.fish ~/.config/fish/completions/k.fish  #**** handles  completion for the 'k' alias
fish -c "alias k=kubectl; funcsave k"


#Step: Install Kubectx and kubens
#Site: https://github.com/ahmetb/kubectx
echo 'Installing Kubectx and Kubens'
runAsRoot git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens

#Step: Kubectx and Kubens Autocomplete & Alias - Fish Shell
#Site: https://github.com/ahmetb/kubectx/tree/master/completion
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
#Site: https://helm.sh/docs/using_helm/#installing-helm
echo 'Installing Helm'
runAsRoot curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > /tmp/get_helm.sh
runAsRoot chmod 700 /tmp/get_helm.sh
runAsRoot /tmp/get_helm.sh
runAsRoot rm /tmp/get_helm.sh

#Step: Install Fisher
#Site: https://github.com/jorgebucaran/fisher
echo 'Installing Fisher'
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

#Step: Install z
#Site: https://github.com/jethrokuan/z
echo 'Installing z - Directory Jumping'
fish -c "fisher add jethrokuan/z"

#Step: Install jq
#Site: https://stedolan.github.io/jq/
echo 'Installing jq - json parsing'
runAsRoot apt-get install jq -y

#Step: Install popeye
#Site: https://github.com/derailed/popeye
echo 'Installing popeye'
releaseURL='https://github.com/derailed/popeye/releases/download/vRELEASENAME/popeye_RELEASENAME_Linux_x86_64.tar.gz'
release=$(curl -s https://api.github.com/repos/derailed/popeye/releases | jq -r '.[0].tag_name' | awk '{print substr($1,2); }')
newURL="${releaseURL//RELEASENAME/$release}"
wget $newURL -O /tmp/popeye.tar.gz
runAsRoot mkdir /opt/popeye
runAsRoot tar -xf /tmp/popeye.tar.gz -C /opt/popeye
runAsRoot ln -s /opt/popeye/popeye /usr/local/bin/popeye

# COOL UTILITIES
#Install pbcopy and pbpaste
echo 'Installing pbcopy and pbpaste'
runAsRoot apt install xclip xsel
fish -c "alias pbcopy='xclip -selection clipboard'; funcsave pbcopy"
fish -c "alias pbpaste='xclip -selection clipboard -o'; funcsave pbpaste"


#Install Parcellite
echo 'Installing Parcellite'
apt-get install parcellite -y

#Installl Remmina for RDP
echo 'Installing Remmina for RDP'
runAsRoot apt-add-repository ppa:remmina-ppa-team/remmina-next -y
runAsRoot apt-get update -y
runAsRoot apt-get install -y remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice
runAsRoot killall remmina

