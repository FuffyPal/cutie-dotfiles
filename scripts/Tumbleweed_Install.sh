sudo zypper dup --no-recommends -y 
sudo zypper addrepo --refresh --check --name "Antigravity RPM Repository" https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm antigravity-rpm
sudo zypper addrepo --refresh --check --name "Packman Repository" -f https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
sudo zypper addrepo --refresh --check --name "Nvidia Repository" -f https://download.nvidia.com/opensuse/tumbleweed NVIDIA
sudo zypper in -y antigravity git git-lfs handbrake-cli handbrake-gtk papirus-icon-theme firewalld firewall-config helix lolcat btop systemd-resolved
sudo zypper install-new-recommends -y
