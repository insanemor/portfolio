#!/bin/bash

# Latest = 3.6
docker run -it --rm \
  --net host --memory 1024mb \
  -v /home/ins:/work \
  --name tools_demo \
  docker.io/insanemor/tools:3.6


# Export Gerais 
export VERSION='3.6'
export PATH_BASE='/home/ins/Applications/cli/conf-clientes/00001'
export PATH_GLOBAL='/home/ins/Applications/cli/conf-clientes/00001/GLOBAL'

# Export FS
export CLIENTE='FS'
export PATH_FULL="$PATH_BASE/$CLIENTE"


# Export V8
export CLIENTE='V8'
export PATH_FULL="$PATH_BASE/$CLIENTE"


echo "
# TOOLS contained all ferramentas.
alias ins-$CLIENTE='docker run -it --rm --net host \
--memory 1024mb \
--userns=keep-id -u $UID:$UID \
-v $PATH_FULL/contained/aws:/home/ins/.aws \
-v $PATH_FULL/contained/ssh:/home/ins/.ssh \
-v $PATH_FULL/contained/kube:/home/ins/.kube \
-v $PATH_FULL/contained/gcloud:/home/ins/.config/gcloud \
-v $PATH_FULL/contained/openvpn:/home/ins/openvpn \
-v $PATH_FULL/confs/helps:/home/ins/helps \
-v $PATH_FULL/confs/confs/gitconfig:/home/ins/.gitconfig \
-v $PATH_FULL/confs/confs/tool-versions:/home/ins/.tool-versions \
-v $PATH_FULL/confs/confs/git-credentials:/home/ins/.git-credentials \
-v $PATH_FULL/confs/confs/zsh_aliases:/home/ins/.zsh_aliases \
-v $PATH_GLOBAL/confs/confs/zsh_extend:/home/ins/.zsh_extend \
-v $PATH_GLOBAL/confs/confs/zsh_aliases_global:/home/ins/.zsh_aliases_global \
-v $PATH_GLOBAL/confs/history/zsh_history:/home/ins/.zsh_history \
-v $PATH_FULL/GIT:/work \ 
--name tools_$CLIENTE \
insanemor/tools:$VERSION'
" >> ~/.zshrc

# 