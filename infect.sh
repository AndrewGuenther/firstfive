#!/bin/bash
TARGET=$1

if [ "$TARGET" == "" ]; then
   TARGET="all"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$TARGET" == "all" ]; then
   echo "=== RETRIEVING SUBMODULES ==="

   git submodule init
   git submodule update

   echo
fi

if [ "$TARGET" == "all" -o "$TARGET" == "special" ]; then
   echo "=== COPYING SPECIFIC FILES ==="

   while read line; do
      args=($line)
      src=${args[0]}
      dest="$(eval echo ${args[1]})"
      echo "$src -> $dest"
      cp $DIR/specific/$src $dest
   done < specific.list

   echo
fi


if [ "$TARGET" == "dependencies" -o "$TARGET" == "all" ]; then
   echo "=== RETRIEVING DEPENDENCIES ==="

   command -v apt-get && INSTALL="apt-get install " && PKMN="apt"
   command -v yum && INSTALL="yum -y install " && PKMN="yum"
   command -v pacman && INSTALL="pacman -S " && PKMN="pacman"

   while read line; do
      args=($line)
      pkg=${line[0]}
      pkmn=${line[1]}

      if [ -z "$pkmn" -o "$pkmn" == "$PKMN" ]; then
         $INSTALL $pkg
      fi
   done < packages.list

   echo
fi
if [ "$TARGET" == "all" -o "$TARGET" == "link" ]; then
   echo "=== LINKING DOTFILES ==="

   # Create a directory to put old dotfiles
   if [ -d ~/.olddots ]; then
      echo "FAIL: A dotfiles backup already exists! Aborting dotfiles copy."
   else
      mkdir ~/.olddots

      # Link dotfiles
      for f in $DIR/link/*; do
         if [ -f ~/.${f##*/} ]; then
            cp ~/.${f##*/} ~/.olddots/.${f##*/}
            rm ~/.${f##*/}
         fi
         echo "$f -> ~/.${f##*/}"
         ln -s $f ~/.${f##*/}
      done
   fi

   echo
fi

if [ "$TARGET" == "all" -a $DIR/custom.sh ]; then
   echo "=== EXECUTING CUSTOM SCRIPT ==="
   source $DIR/custom.sh
fi
