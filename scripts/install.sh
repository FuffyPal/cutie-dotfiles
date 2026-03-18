rpmfusion="
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
"

sudo dnf install -y $rpmfusion

sudo dnf install -y --nogpgcheck --repofrompath terra,https://repos.fyralabs.com/terra$(rpm -E %fedora) terra-release

sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager setopt google-chrome.enabled=1
sudo dnf config-manager setopt rpmfusion-nonfree-nvidia-driver.enabled=1

sudo tee /etc/yum.repos.d/antigravity.repo << 'EOL'
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=0
EOL

package="
podman
podman-docker
podman-compose
firewalld
firewall-config
firewall-applet
flatpak
vim
gnome-tweaks
papirus-icon-theme
antigravity
git-lfs
git
ptyxis
helix
lolcat
snapper
python3-dnf-plugin-snapper
btrfs-assistant
ptyxis
wtype
gtk-layer-shell
"

nvidia="
akmod-nvidia-open
xorg-x11-drv-nvidia-cuda
vulkan
xorg-x11-drv-nvidia-cuda-libs
libva-nvidia-driver
libva-utils
vdpauinfo
"
sudo dnf update -y
sudo dnf install $package


if command -v lspci > /dev/null; then
    if lspci | grep -i nvidia > /dev/null; then
        sudo dnf install -y $nvidia
    else
        echo "Nvidia GPU not found"
    fi
else
    echo "lspci command not found"
fi

wget https://github.com/cjpais/Handy/releases/download/v0.7.11/Handy-0.7.11-1.x86_64.rpm
sudo dnf install -y ./Handy-0.7.11-1.x86_64.rpm
rm Handy-0.7.11-1.x86_64.rpm
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v3.0.0-beta-3/appimagelauncher_3.0.0-beta-2-gha287.96cb937_amd64.deb
sudo dnf install -y ./appimagelauncher_3.0.0-beta-2-gha287.96cb937_amd64.deb
rm appimagelauncher_3.0.0-beta-2-gha287.96cb937_amd64.deb