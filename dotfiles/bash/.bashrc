# Load .bash_profile which does all the setup
if [[ "$-" != *i* ]]; then
    # Non-interactive mode, i.e. an ssh session - we probably want
    # Python, so load up the base miniconda package
    export PATH=$HOME/miniconda/bin
    return
fi
source ~/.bash_profile;
