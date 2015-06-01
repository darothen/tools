if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Initialization for FDK command line tools.Mon Dec 29 15:04:37 2014
FDK_EXE="/home/daniel/bin/FDK/Tools/linux"
PATH=${PATH}:"/home/daniel/bin/FDK/Tools/linux"
export PATH
export FDK_EXE
