FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y \
      neovim \
      curl \
      nodejs \
      git-all \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG USER=dtang
RUN useradd -m -s /bin/bash -G sudo ${USER} && \
    echo "${USER}:${USER}" | chpasswd
USER ${USER}

RUN sh -c 'curl -fLo /home/${USER}/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN mkdir -p /home/${USER}/.config/nvim
