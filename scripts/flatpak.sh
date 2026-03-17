flatpak_packages=(
    com.github.rafostar.Clapper
    org.localsend.localsend_app
    io.gitlab.theevilskeleton.Upscaler
    app/com.github.tchx84.Flatseal
    com.mattjakeman.ExtensionManager
    org.mozilla.Thunderbird
    com.github.wwmm.easyeffects
    org.torproject.torbrowser-launcher
    net.blockbench.Blockbench
    org.libreoffice.LibreOffice
    app.zen_browser.zen
    org.gnome.Loupe
    dev.vencord.Vesktop
    com.protonvpn.www
    #org.gnome.World.PikaBackup
    #dev.deedles.Trayscale
    io.ente.auth
    com.usebottles.bottles
    #de.haeckerfelix.Fragments
    #io.podman_desktop.PodmanDesktop
)

flatpak_repo_user="flatpak --user remote-add --if-not-exists flathub_user https://dl.flathub.org/repo/flathub.flatpakrepo"
flatpak_repo="flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo"

flatpak_install="flatpak install -y -u "

$flatpak_repo_user
$flatpak_repo


$flatpak_install ${flatpak_packages[@]}