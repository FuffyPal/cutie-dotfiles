sudo zypper dup --no-recommends -y 
sudo zypper --gpg-auto-import-keys addrepo --refresh --check --name "Antigravity RPM Repository" https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm antigravity-rpm
sudo zypper --gpg-auto-import-keys addrepo --refresh --check --name "Packman Repository" -f https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Leap_16.0/ packman
sudo zypper --gpg-auto-import-keys addrepo --refresh --check --name "Nvidia Repository" -f https://download.nvidia.com/opensuse/leap/16.0 NVIDIA
sudo zypper --gpg-auto-import-keys addrepo --refresh --check --name "Visual Studio Code" https://packages.microsoft.com/yumrepos/vscode vscode
sudo zypper ref
sudo zypper in -y code git git-lfs papirus-icon-theme firewalld firewall-config helix btop systemd-resolved  zram-generator  systemd-zram-service podman podman-docker unzip
sudo zypper install-new-recommends
sudo systemctl enable --now zramswap.service