#!/bin/bash
sudo apt-get install xorg openbox openbox-menu suckless-tools obmenu lxappearance terminator htop libpam-google-authenticator openssh-server
echo "Iniciando configuração do Google Authenticator:"
google-authenticator
echo "Configurando o Google Authenticator para SSH"
echo "  Escrevendo em 'auth required pam_google_authenticator.so' em /etc/pam.d/sshd"
sudo ex +g/pam_google_authenticator.so/d -cwq /etc/ssh/sshd_config
echo "auth required pam_google_authenticator.so" | sudo tee -a /etc/pam.d/sshd > /dev/null
echo "  Reescrevendo a configuração de ChallengeResponseAuthentication para yes"
sudo ex +g/ChallengeResponseAuthentication/d -cwq /etc/ssh/sshd_config
echo 'ChallengeResponseAuthentication yes' | sudo tee -a /etc/ssh/sshd_config > /dev/null
echo "Reiniciando o servidor openssh"
sudo /etc/init.d/ssh restart
