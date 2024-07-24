FROM debian:sid-slim

ARG USER=ins
ARG UID=1000
ARG GID=100

# Install dependencies
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libnss-sss \
    vim \
    wget \
    curl \
    perl \
    less \
    libpcre3-dev \
    zsh \
    fonts-powerline \
    python3.12-venv \
    git \
    unzip \
    sudo \
    npm \
    zlib1g-dev \
    apt-transport-https \
    ca-certificates \
    gnupg \
    openvpn \
    ssh \
    locales 

RUN locale-gen en_US.UTF-8

# Set environment variables
ENV USER  ${USER}
ENV HOME  /home/${USER}

# Create user and setup permissions on /etc/sudoers
RUN useradd -m -s /bin/bash -N -u $UID $USER && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    chmod g+w /etc/passwd 

RUN mkdir -p /work \
    && chown -R ins:root /work

WORKDIR /work

USER ins

# Install Oh My Zsh and plugins
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf && \
    $HOME/.fzf/install --all

# Copia os arquivos defalt
COPY fzf.zsh  $HOME/.fzf.zsh
COPY p10k.zsh  $HOME/.p10k.zsh
COPY zshrc  $HOME/.zshrc
COPY zshrc  $HOME/.zshrc

# Install ASDF 
RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.11.1
COPY .tool-versions $HOME/.tool-versions

# Install Nerdfonts 
# RUN git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts.git  $HOME/.nerdfonts
# RUN $HOME/.nerdfonts/install.sh

#######  Finalizado a Imagem BASE ( pensar em criar outra imagem e separar como as builder )

# # Troca o shell default
# SHELL ["/bin/zsh", "-c"]

#RUN source $HOME/.zshrc

# Install ASDF plugins and tools
RUN zsh -c "source $HOME/.zshrc && cd $HOME && cut -d' ' -f1 $HOME/.tool-versions | xargs -I{} asdf plugin add {} && asdf install"


# # Instala as ferramentas configurada no tools 
# RUN source $HOME/.zshrc ; \
#     cd $HOME ; \
#     cut -d' ' -f1 $HOME/.tool-versions | xargs -i asdf plugin add  {} ; \
#     asdf install

# Install AWSP
RUN wget -O $HOME/awsp_functions.sh https://raw.githubusercontent.com/antonbabenko/awsp/master/awsp_functions.sh && \
    chmod +x $HOME/awsp_functions.sh

    

CMD ["zsh"]
