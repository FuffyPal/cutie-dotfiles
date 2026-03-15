#!/bin/bash

echo "Enable rpm fusion"
rpmfusion="
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
"

sudo dnf install -y $rpmfusion
if [ $? -eq 0 ]; then
    echo "Rpm Fusion successful ... "
else
    echo "Rpm Fusion  unsuccessful !!!"
    exit 1
fi

fedora_ver="$(rpm -E %fedora)"
if [ "$fedora_ver" -lt 42 ]; then
    echo "Mullvad repo Enable"
    sudo dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
    if [ $? -eq 0 ]; then
        echo "Mullvad repo successful ... "
    else
        echo "Mullvad repo  unsuccessful !!!"
        exit 1
fi

fi

echo "enable terra repo"
sudo dnf install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
if [ $? -eq 0 ]; then
    echo "terra repo successful ... "
else
    echo "terra repo  unsuccessful !!!"
    exit 1
fi

echo "google chrome and nvidia driver repo"
sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager setopt google-chrome.enabled=1
sudo dnf config-manager setopt rpmfusion-nonfree-nvidia-driver.enabled=1

if [ $? -eq 0 ]; then
    echo "google chrome and nvidia driver repo successful ... "
else
    echo "google chrome and nvidia driver repo  unsuccessful !!!"
    exit 1
fi

echo "Enable unityhub repo"
sudo sh -c 'echo -e "[unityhub]\nname=Unity Hub\nbaseurl=https://hub.unity3d.com/linux/repos/rpm/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://hub.unity3d.com/linux/repos/rpm/stable/repodata/repomd.xml.key\nrepo_gpgcheck=1" > /etc/yum.repos.d/unityhub.repo'
if [ $? -eq 0 ]; then
    echo "unityhub repo successful ... "
else
    echo "unityhub repo  unsuccessful !!!"
    exit 1
fi

echo "Enable vscodium repo"
sudo tee -a /etc/yum.repos.d/vscodium.repo << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
EOF
if [ $? -eq 0 ]; then
    echo "vscodium repo successful ... "
else
    echo "vscodium repo  unsuccessful !!!"
    exit 1
fi

echo "Enable antigravity repo"
sudo tee /etc/yum.repos.d/antigravity.repo << 'EOL'
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=0
EOL
if [ $? -eq 0 ]; then
    echo "antigravity repo successful ... "
else
    echo "antigravity repo  unsuccessful !!!"
    exit 1
fi


package="
podman
podman-docker
podman-compose
firewalld
firewall-config
firewall-applet
HandBrake
HandBrake-gui
google-chrome-stable
flatpak
vim
gnome-tweaks
stow
papirus-icon-theme
kmodtool
antigravity
akmods
mokutil
openssl
steam
bzip3
git-lfs
git
tailscale
nextcloud-client
ptyxis
helix
lolcat
yt-dlp
yt-dlp-bash-completion
ffmpeg-free
"

nvidia="
akmod-nvidia
xorg-x11-drv-nvidia-cuda
xorg-x11-drv-nvidia-cuda-libs
vulkan
libva-utils
vdpauinfo
"

echo "Installing basic packages..."
sudo dnf install -y $package
if [ $? -eq 0 ]; then
    echo "Basic Packages successful ... "
else
    echo "Basic Packages  unsuccessful !!!"
    exit 1
fi

echo "Virt Manager Setup ..."
sudo dnf group install -y --with-optional virtualization
if [ $? -eq 0 ]; then
    sudo systemctl enable --now libvirtd
    sudo usermod -aG libvirt $USER
    echo "Virt Manager Setup successful ... "
else
    echo "Virt Manager Setup unsuccessful !!!"
    exit 1
fi

echo "Secure boot enable ..."
echo "Secure boot ASCII en keybord"
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

echo "system upgrade"
sudo dnf update -y
if [ $? -eq 0 ]; then
    echo "system upgrade successfull ..."
else
    echo "system upgrade unsuccsessfull !!!"
    exit 1
fi

if command -v lspci > /dev/null; then
    if lspci | grep -i nvidia > /dev/null; then
        echo "NVIDIA GPU found"
        echo "Installing Nvidia"
        sudo dnf install -y $nvidia
        if [ $? -eq 0 ]; then
            echo "NVIDIA GPU successful ... "
            echo "NVIDIA Container Toolkit Repo Activated..."
            curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
              sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
            if [ $? -eq 0 ]; then
                echo "NVIDIA Container Toolkit Repo Activated Successfully"
                echo "NVIDIA Container Toolkit Installed ..."
                sudo dnf install -y nvidia-container-toolkit nvidia-container-toolkit-base libnvidia-container-tools libnvidia-container1
                if [ $? -eq 0 ]; then
                    echo "NVIDIA Container Toolkit Installed Successfully"
                else
                    echo "NVIDIA Container Toolkit Installation Failed"
                    exit 1
                fi
            else
                echo "NVIDIA Container Toolkit Repo Activation Failed"
                exit 1
            fi
        else
            echo "NVIDIA GPU  unsuccessful !!!"
            exit 1
        fi

    else
        echo "Nvidia GPU not found"
    fi
else
    echo "lspci command not found"
fi
