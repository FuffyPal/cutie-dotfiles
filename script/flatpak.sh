echo "helloowww it is flatpak setup and flatpak app installing"
echo "Flatpak installed?"
read -p "y/n " choice
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
        G4Music            - Fast and fluid music player
        Tor Browser        - Privacy and anonymity browser
        ONLYOFFICE         - Office productivity suite
        Blockbench         - Low-poly 3D modeling
        Zen Browser        - Modern, minimalist web browser
        OnionShare         - Securely share files via Tor
        Loupe              - GNOME image viewer
        Element (Riot)     - Matrix collaboration client
        Vesktop            - Discord client with Vencord patches
        Pika Backup        - Simple backups based on borg
        Trayscale          - Tailscale GUI client
        Ente Auth          - 2FA authenticator with cloud sync
      "
  echo "heyy do u confirm"
  read -p "y/n " twochoice
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
    io.gitlab.librewolf-community
    com.github.rafostar.Clapper
    org.localsend.localsend_app
    io.gitlab.theevilskeleton.Upscaler
    it.mijorus.gearlever
    app/com.github.tchx84.Flatseal
    com.termius.Termius
    org.prismlauncher.PrismLauncher
    com.mattjakeman.ExtensionManager
    org.mozilla.Thunderbird
    com.github.wwmm.easyeffects
    net.veloren.airshipper
    com.github.neithern.g4music
    org.torproject.torbrowser-launcher
    org.onlyoffice.desktopeditors
    net.blockbench.Blockbench
    app.zen_browser.zen
    org.remmina.Remmina
    org.onionshare.OnionShare
    org.gnome.Loupe
    im.riot.Riot
    dev.vencord.Vesktop
    org.gnome.World.PikaBackup
    dev.deedles.Trayscale
    io.ente.auth
    "
    echo "Flatpak repolarrı ekleniyor"
    ${FLATPAK_REPO_ADD} ${FRL_FLATHUB}
    echo "flatpak uygulamaları yükleniyor"
    ${FLATPAK_INSTALL} ${FPL_REAL}
    exit 1
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
