flatpak_packages=(
    dev.vencord.Vesktop
    com.usebottles.bottles
    io.github.dvlv.boxbuddyrs
    io.podman_desktop.PodmanDesktop
)

flatpak_repo_user="flatpak --user remote-add --if-not-exists flathub_user https://dl.flathub.org/repo/flathub.flatpakrepo"
flatpak_repo="flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo"

flatpak_install="flatpak install -y -u "

$flatpak_repo_user
$flatpak_repo


$flatpak_install ${flatpak_packages[@]}
