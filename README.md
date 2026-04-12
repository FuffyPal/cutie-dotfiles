# Fedora Dotfiles

Kişisel Fedora Workstation kurulum scripti ve konfigürasyon dosyaları.

## Yapı

```
dotfiles/
├── home/
│   ├── .bashrc         # Shell konfigürasyonu
│   ├── .vimrc          # Vim ayarları
│   └── .gitconfig      # Git ayarları
├── system/
│   ├── dnf.conf        # DNF paket yöneticisi ayarları
│   ├── resolved.conf   # systemd-resolved (DoT + DNSSEC)
│   └── snapper-root.conf # Btrfs snapshot ayarları
├── scripts/
│   ├── debloat.sh      # Gereksiz uygulamaları kaldır
│   ├── flatpak.sh      # Flatpak uygulamaları kur
│   └── nvidia.sh       # NVIDIA sürücü + container toolkit
├── install.sh          # Ana kurulum scripti
└── README.md
```

## Kullanım

```bash
git clone https://github.com/kullanici/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh scripts/*.sh
./install.sh
```

### Seçenekler

| Komut | Açıklama |
|---|---|
| `./install.sh` | Tam kurulum |
| `./install.sh --symlinks` | Sadece dotfile symlink'lerini güncelle |
| `./install.sh --no-nvidia` | NVIDIA kurulumunu atla |

## Ne yapıyor?

1. **Repo'lar** — RPM Fusion (free + nonfree), Terra, VS Code
2. **Debloat** — GNOME bloatware, Firefox, LibreOffice (dnf) kaldırılır
3. **DNF paketleri** — geliştirici araçları, Podman, Helix, btop vs.
4. **Flatpak** — Flathub'dan uygulama listesi kurulur
5. **NVIDIA** — GPU varsa sürücüler + container toolkit otomatik
6. **Secure Boot** — akmods sertifikası oluşturulur ve MOK'a import edilir
7. **Sistem** — dnf.conf, systemd-resolved (DoT/DNSSEC), firewalld, snapper
8. **Symlink'ler** — dotfiles home dizinine bağlanır

## DNS Yapılandırması

`resolved.conf` şunları etkinleştirir:

- **DNS**: Cloudflare (1.1.1.1) + Quad9 (9.9.9.9)
- **DNS over TLS**: açık
- **DNSSEC**: açık
- **Cache**: açık

## Notlar

- Secure Boot için yeniden başlatma sonrasında **MOK Manager**'dan sertifikayı onaylamanız gerekir.
- NVIDIA sürücüsü akmods kullandığından ilk yeniden başlatmada modül derlenir.
- Snapper, btrfs üzerinde çalışmayan sistemlerde otomatik atlanır.
