#!/bin/bash
TARGET=$1

command -v apt-get && INSTALL="apt-get install " && PKMN="apt"
command -v yum && INSTALL="yum -y install " && PKMN="yum"
command -v pacman && INSTALL="pacman -S " && PKMN="pacman"
command -v brew && INSTALL="brew install " && PMMN="brew"

case "$TARGET" in
   git://*|git@*|https://*)
      if [ ! $(command -v git) ]; then
         echo "=== INSTALLING GIT ==="
         $INSTALL git
      fi
      git clone $TARGET firstfive
      cd firstfive
      ;;
   *)
      cd $TARGET
      ;;
esac

echo
echo "=== SYNCING SUBMODULES ==="

if [ $(ls .git | wc -l) ]; then
   git submodule update --init --recursive
fi

echo
echo "=== COPYING SPECIFIC FILES ==="

while read line; do
   args=($line)
   src=${args[0]}
   dest="$(eval echo ${args[1]})"
   append=${args[2]}
   echo "$src -> $dest"
   if [ "$append" == "a" ]; then
      cat specific/$src >> $dest
   else
      cp specific/$src $dest
   fi
done < specific.list

echo
echo "=== RETRIEVING DEPENDENCIES ==="

while read line; do
   args=($line)
   pkg=${line[0]}
   pkmn=${line[1]}

   if [ -z "$pkmn" -o "$pkmn" == "$PKMN" ]; then
      $INSTALL $pkg
   fi
done < packages.list

echo
echo "=== LINKING DOTFILES ==="

# Create a directory to put old dotfiles
if [ -d ~/.olddots ]; then
   echo "FAIL: A dotfiles backup already exists! Aborting dotfiles copy."
else
   mkdir ~/.olddots

   # Link dotfiles
   for f in link/*; do
      if [ -f ~/.${f##*/} ]; then
         cp ~/.${f##*/} ~/.olddots/.${f##*/}
         rm ~/.${f##*/}
      fi
      echo "$f -> ~/.${f##*/}"
      ln -s $f ~/.${f##*/}
   done
fi

echo
echo "=== EXECUTING CUSTOM SCRIPT ==="

source custom.sh

echo
echo "=== SETUP COMPLETE! ==="
