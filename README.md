# FirstFive

As my dotfiles repo began to grow, I was inspired by Bryan Kennedy's post [My First 5 Minutes On A Server; Or, Essential Security for Linux Servers](http://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers) to create a slightly more general solution for setting up a new system to my liking. Are there other tools to do this? Definitely, but I feel like this script is a nice bare minimum setup script that offers a good level of flexibility.

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
./infect.sh [all|packages|specific|link]
```

* **all**: Run all targets (if no target is specified, this is the default)
* **packages**: Only install packages
* **specific**: Only copy "specific" files
* **link**: only link dotfiles

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

If you wish to have a file copied to a specific location, just place it in the ```specific``` folder (or subfolder) and list it in the ```specific.list``` file. You can also use the ```$DIR``` variable to indicate the directory in which ```infect.sh``` is located. (This can be useful if you want to inject files into submodules after they are pulled)

Here's an example:
```
my.zsh-theme    $DIR/link/oh-my-zsh/custom/
ssh/id_rsa.pub  ~/.ssh/
ssh/config      ~/.ssh/
```

### Link

The simplist of the bunch. Anything placed in the ```link``` directory will be recursively copied into the home directory and prefixed with a ```.```. Any files which already exist will be backed up in the ```.olddots``` directory.

## Example
You can see my configuration [in my seperate dotfiles repo.](https://github.com/AndrewGuenther/dotfiles)
