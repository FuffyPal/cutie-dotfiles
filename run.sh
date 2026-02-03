rm -f ~/.bashrc

echo ">> Applying Stow settings..."
cd stow
stow -t ~ bash
stow -t ~ helix
cd ..

# 4. Run your custom scripts
echo ">> Applying custom system settings..."
chmod +x script/*.sh
./script/fedora.sh
./script/dns.sh
./script/firewalld.sh
./script/flatpak.sh
./script/zapret.sh  

echo ">> Everything is ready! You might need to logout and login again."