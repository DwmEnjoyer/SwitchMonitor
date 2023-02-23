#!/bin/sh

read -p 'Elige una distribución(arch/gentoo/ubuntu):' distro
read -p 'Elige una shell(bash/zshrc):' shell
shellfile="~/${shell}rc"
if [ $distro == 'arch' ]
then
  sudo pacman -S go
elif [ $distro == 'ubuntu' ]
then
  sudo apt install golang
elif [ $distro == 'gentoo' ]
then
  sudo emerge --ask dev-lang/go
else
  echo 'Distribución no reconocida'
  exit 1
fi
go install github.com/charmbracelet/gum@latest
echo "export PATH=$PATH:/home/${USER}/go/bin" >> shellfile
chmod +x switchmonitor.sh
sudo cp switchmonitor.sh /usr/local/bin

