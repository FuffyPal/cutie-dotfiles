flatpak_packages=(
    com.mattermost.Desktop
    dev.vencord.Vesktop
    com.valvesoftware.Steam
)

flatpak_repo_user="flatpak --user remote-add --if-not-exists flathub_user https://dl.flathub.org/repo/flathub.flatpakrepo"
flatpak_repo="flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo"

flatpak_install="flatpak install -y -u "

$flatpak_repo_user
$flatpak_repo


$flatpak_install ${flatpak_packages[@]}