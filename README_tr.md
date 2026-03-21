<div align="center">

# 🐱 cutie-dotfiles

**OpenSUSE Leap 16 için kişiselleştirilmiş dotfiles koleksiyonu**

*GNOME Masaüstü ortamıyla birlikte güzel, işlevsel ve tutarlı bir sistem deneyimi için*

![OpenSUSE](https://img.shields.io/badge/OpenSUSE-Leap%2016-73BA25?style=for-the-badge&logo=opensuse&logoColor=white)
![GNOME](https://img.shields.io/badge/GNOME-Desktop-4A86CF?style=for-the-badge&logo=gnome&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-pink?style=for-the-badge)

[🇬🇧 English](./README.md)

</div>

---

## 📖 Hakkında

Bu repo, **OpenSUSE Leap 16** üzerine kurulum sırasında ek bileşen olarak **GNOME masaüstü ortamı** seçilmiş varsayılan kurulum temel alınarak hazırlanmış kişisel dotfiles koleksiyonudur. Sistem kurulumunu hızlandırmak, tutarlı bir görünüm ve his elde etmek ve sıklıkla kullanılan ayarları tek bir yerden yönetmek amacıyla oluşturulmuştur.

> **Hedef Sistem:**
> - **Dağıtım:** OpenSUSE Leap 16
> - **Kurulum Tipi:** Varsayılan kurulum + GNOME Desktop seçeneği eklendi
> - **Masaüstü Ortamı:** GNOME (ek olarak seçilmiş)

---

## 🗂️ Klasör Yapısı

```
cutie-dotfiles/
│
├── assets/                  # Görsel kaynaklar
│   ├── backgrounds/         # Masaüstü duvar kağıtları
│   └── profile/             # Profil fotoğrafı
│
├── scripts/                 # Kurulum ve yardımcı betikler
│   ├── install.sh           # Ana kurulum betiği
│   ├── flatpak.sh           # Flatpak uygulama kurulumları
│   └── ...                  # Diğer betikler
│
├── gnome/                   # GNOME'a özel yapılandırmalar
│   ├── extensions/          # GNOME uzantı yapılandırmaları
│   ├── settings/            # dconf / gsettings dökümleri
│   └── themes/              # Tema dosyaları
│
├── config/                  # Uygulama yapılandırma dosyaları (~/.config altına gidecekler)
│
└── README.md
```

---

## 🔌 GNOME Uzantıları

Aşağıdaki uzantılar GNOME'un resmi uzantı mağazasından veya ilgili kaynaklardan **manuel olarak** kurulmalıdır. GNOME'un kısıtlamaları nedeniyle bu uzantılar otomatik kurulum betiğine dahil edilememiştir.

> 💡 Uzantıları kurmak için [extensions.gnome.org](https://extensions.gnome.org) adresini veya **Extension Manager** uygulamasını kullanabilirsiniz.

| # | Uzantı Adı | Açıklama |
|---|-----------|----------|
| 1 | **AppIndicator and KStatusNotifierItem Support** | Sistem tepsisinde uygulama simgelerini (AppIndicator) gösterir |
| 2 | **Battery Health Charging** | Pili belirli bir yüzdenin üzerinde şarj etmeyerek pil ömrünü korur |
| 3 | **Bluetooth Battery Meter** | Bluetooth cihazlarının pil seviyesini sistem tepsisinde gösterir |
| 4 | **Blur my Shell** | Uygulama başlatıcı, panel ve kilit ekranına bulanıklık (blur) efekti ekler |
| 5 | **Caffeine** | Ekranın otomatik kilitlenmesini ve uyku moduna geçmesini engeller |
| 6 | **Clipboard Indicator** | Pano geçmişini yönetmek için gelişmiş bir pano yöneticisi |
| 7 | **Color Picker** | Ekrandaki herhangi bir pikselin rengini almak için renk seçici aracı |
| 8 | **Compiz-alike Windows Effects** | Pencere hareketlerine Compiz benzeri animasyon ve efektler ekler |
| 9 | **Dash to Dock** | Uygulamalar çubuğunu (dash) her zaman görünür bir dock'a dönüştürür |
| 10 | **Forge** | Manuel döşeme (tiling) pencere yöneticisi; pencereleri otomatik düzenler |
| 11 | **GSConnect** | KDE Connect protokolü ile Android cihazlarıyla entegrasyon sağlar |
| 12 | **Just Perfection** | GNOME Shell öğelerini (panel, aktiviteler, konum çubuğu vb.) özelleştirir |
| 13 | **Media Controls** | Üst panelde oynatılan medyanın bilgilerini ve kontrollerini gösterir |
| 14 | **Quick Settings Audio Panel** | Hızlı ayarlar menüsüne gelişmiş ses kontrolü paneli ekler |
| 15 | **Quick Settings Touchpad Toggle** | Hızlı ayarlar menüsünden touchpad'i hızlıca açıp kapatmayı sağlar |
| 16 | **Restart to...** | Güç menüsüne farklı önyükleme seçenekleri (UEFI, Windows vb.) ekler |
| 17 | **Tiling Shell** | Akıllı pencere döşeme (tiling) desteği; pencereleri bölgelere yapıştırır |
| 18 | **User Avatar in Quick Settings** | Hızlı ayarlar menüsünde kullanıcı avatar fotoğrafını gösterir |
| 19 | **cloudflare-warp-toggle** | Warp terminal uygulamasını hızlıca açmak için kısayol sunar |
| 20 | **Weather O'Clock** | Üst panelde saat ile birlikte hava durumu bilgisini gösterir |
| 21 | **Wiggly** | Pencereleri sürüklerken eğlenceli bir yavaş titreme animasyonu ekler |

---

## ⚡ Hızlı Başlangıç

```bash
# Repoyu klonla
git clone https://github.com/kullanici-adi/cutie-dotfiles.git ~/cutie-dotfiles
cd ~/cutie-dotfiles

# Ana kurulum betiğini çalıştır
bash scripts/install.sh
```

---

## 🤝 Katkı

Bu repo kişisel kullanım için hazırlanmıştır, ancak fikirlere ve geri bildirimlere her zaman açığım. Sorunları *Issues* sekmesinden iletebilirsiniz.

---

<div align="center">
  <sub>Made with 💕 on OpenSUSE Leap</sub>
</div>
