# Ensure github directory exists in documents dir
mkdir -p ~/Documents/Github
# Cd into github dir
cd ~/Documents/Github

# Update .bashrc
cp -f -p -v ./bash/.bashrc ~/
# Update konsole
cp -f -p -v -r ./konsole/* ~/.local/share/konsole/
# Update .vimrc
cp -f -p -v ./vim/.vimrc ~/


# Make sure we're still in the Github dir
cd ~/Documents/Github
# Clone nerd font repo, this might take a while
git clone --depth 1 "https://github.com/ryanoasis/nerd-fonts.git"
# Move to nerd-fonts dir
cd ~/Documents/Github/nerd-fonts/
# Install Ubuntu and Ubuntu Mono fonts
./install.sh UbuntuNerdFont
./install.sh UbuntuMonoNerdFont
