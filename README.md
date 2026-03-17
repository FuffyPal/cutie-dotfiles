<div align="center">

# 🐱 cutie-dotfiles

**A personal dotfiles collection for OpenSUSE Leap 16**

*For a beautiful, functional, and consistent system experience with GNOME Desktop*

![OpenSUSE](https://img.shields.io/badge/OpenSUSE-Leap%2016-73BA25?style=for-the-badge&logo=opensuse&logoColor=white)
![GNOME](https://img.shields.io/badge/GNOME-Desktop-4A86CF?style=for-the-badge&logo=gnome&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-pink?style=for-the-badge)

[🇹🇷 Türkçe](./README_tr.md)

</div>

---

## 📖 About

This repository is a personal dotfiles collection based on a **default OpenSUSE Leap 16 installation** with the **GNOME Desktop environment** selected as an additional component during setup. It was designed to speed up system configuration, maintain a consistent look and feel, and manage frequently used settings from a single place.

> **Target System:**
> - **Distribution:** OpenSUSE Leap 16
> - **Installation Type:** Default installation + GNOME Desktop option selected
> - **Desktop Environment:** GNOME (additionally selected)

---

## 🗂️ Folder Structure

```
cutie-dotfiles/
│
├── assets/                  # Visual resources
│   ├── backgrounds/         # Desktop wallpapers
│   └── profile/             # Profile picture
│
├── scripts/                 # Installation and utility scripts
│   ├── install.sh           # Main installation script
│   ├── flatpak.sh           # Flatpak application installations
│   └── ...                  # Other scripts
│
├── gnome/                   # GNOME-specific configurations
│   ├── extensions/          # GNOME extension configurations
│   ├── settings/            # dconf / gsettings dumps
│   └── themes/              # Theme files
│
├── config/                  # App config files (to be placed under ~/.config)
│
└── README.md
```

---

## 🔌 GNOME Extensions

The following extensions must be installed **manually** from the GNOME extensions store or their respective sources. Due to GNOME's restrictions, these extensions cannot be included in the automated installation script.

> 💡 You can install extensions via [extensions.gnome.org](https://extensions.gnome.org) or the **Extension Manager** app.

| # | Extension Name | Description |
|---|---------------|-------------|
| 1 | **AppIndicator and KStatusNotifierItem Support** | Displays application icons (AppIndicator) in the system tray |
| 2 | **Battery Health Charging** | Protects battery life by preventing charging above a set percentage |
| 3 | **Bluetooth Battery Meter** | Shows Bluetooth device battery levels in the system tray |
| 4 | **Blur my Shell** | Adds blur effects to the app launcher, panel, and lock screen |
| 5 | **Caffeine** | Prevents the screen from auto-locking and the system from sleeping |
| 6 | **Clipboard Indicator** | An advanced clipboard manager for managing clipboard history |
| 7 | **Color Picker** | A color picker tool to grab the color of any pixel on the screen |
| 8 | **Compiz-alike Windows Effects** | Adds Compiz-like animations and effects to window movements |
| 9 | **Dash to Dock** | Transforms the app launcher (dash) into an always-visible dock |
| 10 | **Forge** | Manual tiling window manager; automatically arranges windows |
| 11 | **GSConnect** | Integrates Android devices via the KDE Connect protocol |
| 12 | **Just Perfection** | Customizes GNOME Shell elements (panel, activities, location bar, etc.) |
| 13 | **Media Controls** | Shows currently playing media info and controls in the top panel |
| 14 | **Quick Settings Audio Panel** | Adds an advanced audio control panel to the quick settings menu |
| 15 | **Quick Settings Touchpad Toggle** | Quickly enable/disable the touchpad from the quick settings menu |
| 16 | **Restart to...** | Adds boot options (UEFI, Windows, etc.) to the power menu |
| 17 | **Tiling Shell** | Smart window tiling support; snaps windows into zones |
| 18 | **User Avatar in Quick Settings** | Displays the user's avatar photo in the quick settings menu |
| 19 | **Warp Toggle** | Provides a shortcut to quickly open the Warp terminal app |
| 20 | **Weather O'Clock** | Shows weather information alongside the clock in the top panel |
| 21 | **Wiggly** | Adds a fun slow wobble animation when dragging windows |

---

## ⚡ Quick Start

```bash
# Clone the repo
git clone https://github.com/username/cutie-dotfiles.git ~/cutie-dotfiles
cd ~/cutie-dotfiles

# Run the main installation script
bash scripts/install.sh
```

---

## 🤝 Contributing

This repo is made for personal use, but I'm always open to ideas and feedback. Feel free to open an issue in the *Issues* tab.

---

<div align="center">
  <sub>Made with 💕 on OpenSUSE Leap</sub>
</div>
