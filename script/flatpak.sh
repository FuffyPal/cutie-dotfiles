echo "helloowww it is flatpak setup and flatpak app installing"
echo "Flatpak installed?"
read -r -p "y/n " choice
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')
if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
    echo "--- Current App List ---"
      echo "
        LibreWolf          - Privacy-focused Firefox fork
        Clapper            - Modern media player (VLC alternative)
        LocalSend          - Local network file sharing
        Upscaler           - Image resolution upscaler
        GearLever          - AppImage manager and installer
        Flatseal           - Flatpak permission manager
        Termius            - SSH and Telnet client
        Prism Launcher     - Minecraft Java edition launcher
        Extension Manager  - GNOME Shell extension manager
        Thunderbird        - Email and calendar client
        Easy Effects       - Audio effects for PipeWire/PulseAudio
        Airshipper         - Veloren (RPG) launcher
        Tor Browser        - Privacy and anonymity browser
        ONLYOFFICE         - Office productivity suite
        Blockbench         - Low-poly 3D modeling
        Zen Browser        - Modern, minimalist web browser
        Loupe              - GNOME image viewer
        Element (Riot)     - Matrix collaboration client
        Vesktop            - Discord client with Vencord patches
        Pika Backup        - Simple backups based on borg
        Trayscale          - Tailscale GUI client
        Ente Auth          - 2FA authenticator with cloud sync
      "
  echo "heyy do u confirm"
  read -r -p "y/n " twochoice
  twochoice=$(echo "$twochoice" | tr '[:upper:]' '[:lower:]')
  if [[ "$twochoice" == "y" || "$twochoice" == "yes" ]]; then
    #FLATPAK DEFUALT
    FLATPAK_INSTALL="flatpak install -y"
    FLATPAK_REMOVE="flatpak uninstall -y --all"
    FLATPAK_REPO_ADD="flatpak remote-add --if-not-exists --user"

    #FLATPAK REPO LIST
    FRL_FLATHUB="flathub https://dl.flathub.org/repo/flathub.flatpakrepo"
    #FLATPAK APP LIST
    FPL_REAL="--user flathub
    com.github.rafostar.Clapper
    org.localsend.localsend_app
    io.gitlab.theevilskeleton.Upscaler
    app/com.github.tchx84.Flatseal
    org.prismlauncher.PrismLauncher
    com.mattjakeman.ExtensionManager
    org.mozilla.Thunderbird
    com.github.wwmm.easyeffects
    net.veloren.airshipper
    org.torproject.torbrowser-launcher
    org.onlyoffice.desktopeditors
    net.blockbench.Blockbench
    app.zen_browser.zen
    org.remmina.Remmina
    it.mijorus.gearlever
    org.gnome.Loupe
    dev.vencord.Vesktop
    org.gnome.World.PikaBackup
    dev.deedles.Trayscale
    org.kde.krita
    io.github.electronstudio.WeylusCommunityEdition
    io.ente.auth
    com.usebottles.bottles
    de.haeckerfelix.Fragments
    org.vinegarhq.Sober
    org.vinegarhq.Vinegar
    io.podman_desktop.PodmanDesktop
    com.vysp3r.ProtonPlus
    "
    echo "Flatpak repolarrı ekleniyor"
    ${FLATPAK_REPO_ADD} ${FRL_FLATHUB}
    echo "flatpak uygulamaları yükleniyor"
    ${FLATPAK_INSTALL} ${FPL_REAL}
    exit 0
  else
        echo "byyyy ... "
        exit 1
  fi


elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
    echo "Owwww okey tchüss ..."
    exit 1
else
    echo "Please Y or N ..."
fi
