# EvalBash
Script created during classes that create you a new vagrant and configure it

# SOFTWARE
This Script is verifying if VirtualBox and Vagrant are installed and if not, it ask you if you want to download those software. 
if you say no, you are rejected by the script. if you say yes, it launch the install.

# ACTION
Then you created a folder and a sync folder. in the inputs you have to at least put one letter or number.
Then you choose your Ubuntu version (only xenial64 for now so envoy)
Then some action are set like the copy of package.sh in the sync folder.

# VAGRANTFILE
The vagrantfile is configure with some sed -i

# VAGRANT UP
the vagrant is strating

# MENU WHAT NEXT
Here you can choose between several actions like show all vagrant on the computer or continue the configuration.
If you choose to show all vagrant, another Menu appear to you which ask you what to do with that list (destroy, connect or halt).
If you choose to continue the configuration you're going to be in SSH

# SSH
Once you're in ssh you have to go to /var/www/html and execute package.sh

# PACKAGE
In this file there is a menu that let you choose which one of the packages you want to install
