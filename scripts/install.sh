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

sudo tee -a /etc/yum.repos.d/vscodium.repo << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
EOF

sudo sh -c 'echo -e "[unityhub]\nname=Unity Hub\nbaseurl=https://hub.unity3d.com/linux/repos/rpm/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://hub.unity3d.com/linux/repos/rpm/stable/repodata/repomd.xml.key\nrepo_gpgcheck=1" > /etc/yum.repos.d/unityhub.repo'

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null


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
code
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
steam-devices
gtk-layer-shell
fuse
fuse-libs
freerdp
btop
rust-analyzer
cargo
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
sudo dnf install -y $package
sudo dnf group install -y container-management
sudo dnf group install -y development-tools


if command -v lspci > /dev/null; then
    if lspci | grep -i nvidia > /dev/null; then
        sudo dnf install -y $nvidia
    else
        echo "Nvidia GPU not found"
    fi
else
    echo "lspci command not found"
fi

sudo kmodgenca -a
if [ $? -eq 0 ]; then
	echo "Secure boot import"
	sudo mokutil --import /etc/pki/akmods/certs/public_key.der
	if [ $? -eq 0 ]; then
		echo "secure boot successfull ..."
	else
		echo "secure boot unsuccessfull ... error import area"
		exit 1
	fi
else
	echo "sucre boot unseccesfull ... error generade"
	sudo kmodgenca -a --force
	if [ $? -eq 0 ]; then
		echo "secure boot import"
		sudo mokutil --import /etc/pki/akmods/certs/public_key.der
		if  [ $? -eq 0 ]; then
			echo "sucre boot successfull ... but force mod"
		else
			echo "secure boot unseccessfull .. error import area"
			exit 1
		fi
	else
		echo "secure boot unseccesfull ... error gnerade force mode"
		exit 1
	fi
fi


wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v3.0.0-beta-3/appimagelauncher_3.0.0-beta-2-gha287.96cb937_x86_64.rpm
sudo dnf install -y ./appimagelauncher_3.0.0-beta-2-gha287.96cb937_x86_64.rpm
rm appimagelauncher_3.0.0-beta-2-gha287.96cb937_x86_64.rpm
sudo rpm -e 'gpg-pubkey(4fa1c3ba-61abda35)' && sudo rpm --import https://pkg.cloudflareclient.com/pubkey.gpg
curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo
sudo dnf install -y cloudflare-warp
wget "https://repo.protonvpn.com/fedora-$(cat /etc/fedora-release | cut -d' ' -f 3)-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.3-1.noarch.rpm"
sudo dnf install -y ./protonvpn-stable-release-1.0.3-1.noarch.rpm
rm protonvpn-stable-release-1.0.3-1.noarch.rpm
sudo dnf install -y proton-vpn-gnome-desktop
wget https://github.com/TibixDev/winboat/releases/download/v0.9.0/winboat-0.9.0-x86_64.AppImage
chmod +x winboat-0.9.0-x86_64.AppImage
./winboat-0.9.0-x86_64.AppImage
echo "you not forget pls /path/to/handy(appimage) --toggle-transcription"
wget https://github.com/cjpais/Handy/releases/download/v0.7.12/Handy_0.7.12_amd64.AppImage
chmod +x Handy_0.7.12_amd64.AppImage
./Handy_0.7.12_amd64.AppImage
