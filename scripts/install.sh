sudo zypper dup --no-recommends -y 
sudo zypper install openSUSE-repos-Leap-NVIDIA -y
sudo zypper install-new-recommends -y
sudo zypper addrepo --refresh--check --name "Antigravity RPM Repository" https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm antigravity-rpm
sudo zypper in -y antigravity 