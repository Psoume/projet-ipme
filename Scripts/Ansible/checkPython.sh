#!/bin/bash

sudo dnf update
sudo dnf install gcc openssl-devel bzip2-devel libffi-devel zlib-devel wget make -y 

if ! command -v wget &> /dev/null; then
    echo "wget n'est pas installé. Installation en cours..."
    sudo dnf install wget
else
    echo "wget est déjà installé."
fi

if [ ! -f "/tmp/Python-3.10.12.tgz" ]; then
    echo "Téléchargement de Python 3.10.12..."
    wget https://www.python.org/ftp/python/3.10.12/Python-3.10.12.tgz -P /tmp
else
    echo "Python 3.10.12 est déjà téléchargé."
fi

if [ ! -d "/tmp/Python-3.10.12" ]; then
    echo "Extraction de Python 3.10.12..."
    tar -xf /tmp/Python-3.10.12.tgz -C /tmp
    cd /tmp/Python-3.10.12
    ./configure --enable-optimizations
    make -j$(nproc)
    sudo make altinstall
else
    echo "Python 3.10.12 est déjà extrait et installé."
fi

