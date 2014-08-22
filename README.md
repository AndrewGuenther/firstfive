# FirstFive
[![Build Status](https://travis-ci.org/AndrewGuenther/firstfive.svg?branch=master)](https://travis-ci.org/AndrewGuenther/firstfive)

As my dotfiles repo began to grow, I was inspired by Bryan Kennedy's post [My First 5 Minutes On A Server; Or, Essential Security for Linux Servers](http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers) and [@icco](https://github.com/icco) to create a slightly more general solution for setting up a new system to my liking. Are there other tools to do this? Definitely, but I feel like this script is a nice bare minimum setup script that offers a good enough level of flexibility.

## Features

* Install packages from multiple package managers:
  * pacman
  * apt-get
  * yum
* Symbolicly link dotfiles
  * Back up existing dotfiles
  * Automatically pull submodules
* Copy files into specified locations
* Execute a custom bash script

## Usage

```
curl -sSL https://raw.githubusercontent.com/AndrewGuenther/firstfive/master/infect.sh | bash -s <YOUR REPO>
```

### Packages

Packages to be install should be specified in the ```packages.list``` file. If a specific package can only be found in a specific package manager, then that package manager can be specified after a space.

Here's an example:
```
vim
zsh
wifi-radar pacman
```

**NOTE:** You **cannot** specify multiple specific package managers on a single line.

### Specific

If you wish to have a file copied to a specific location, just place it in the ```specific``` folder (or subfolder) and list it in the ```specific.list``` file. You can also use the ```$DIR``` variable to indicate the directory in which ```infect.sh``` is located (This can be useful if you want to inject files into submodules after they are pulled). You can also add an "a" to the end of a line to indicate you wish for the file to be appended to rather than overwritten.

Here's an example:
```
my.zsh-theme    $DIR/link/oh-my-zsh/custom/
ssh/id_rsa.pub  ~/.ssh/
ssh/config      ~/.ssh/
sources.list    /etc/apt/sources.list a
```

### Link

The simplist of the bunch. Anything placed in the ```link``` directory will be recursively copied into the home directory and prefixed with a ```.```. Any files which already exist will be backed up in the ```.olddots``` directory.

## Example

You can see my configuration [in my seperate dotfiles repo.](https://github.com/AndrewGuenther/dotfiles)

## Acknowledgements

[@icco](https://github.com/icco) and [his dotfile repo](https://github.com/icco/dotFiles) for persuading me to create a dotfiles repo in the first place.
