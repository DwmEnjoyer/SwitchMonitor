#!/bin/sh

printf 'Elige una distribución(arch/gentoo/ubuntu): '
read -r distro
printf 'Elige una shell(bash/zsh): '
read -r shell
shellfile="${HOME}/.${shell}rc"
if [ $distro = 'arch' ]
then
  sudo pacman -S go
elif [ $distro = 'ubuntu' ]
then
  sudo apt install golang
elif [ $distro = 'gentoo' ]
then
  sudo emerge --ask dev-lang/go
else
  echo 'Distribución no reconocida'
  exit 1
fi
go install github.com/charmbracelet/gum@latest
echo "export PATH=\$PATH:/home/${USER}/go/bin" >> $shellfile
chmod +x switchmonitor.sh
sudo cp switchmonitor.sh /usr/local/bin

