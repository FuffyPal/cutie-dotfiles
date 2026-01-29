#!/usr/bin/env bash

# Hata oluşursa betiği durdur
set -e

# Renkler
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # Renk Yok

echo -e "${BLUE}🔍 Nix Flake kontrol ediliyor...${NC}"
# Git'e eklenmemiş dosyalar varsa Nix görmez, o yüzden geçici olarak ekliyoruz
git add -N .

if nix flake check; then
    echo -e "${GREEN}✅ Kod yapısı (Syntax) doğru.${NC}"
else
    echo "❌ Kodda hata var, lütfen kontrol et."
    exit 1
fi

echo -e "${BLUE}🛠️  Test amaçlı inşa ediliyor (Dry-run)...${NC}"
if nix build .#homeConfigurations.fluffypal.activationPackage --extra-experimental-features "nix-command flakes"; then
    echo -e "${GREEN}✅ İnşa başarılı! (result klasörü oluşturuldu)${NC}"
    rm -rf result # Test bittiği için temizliyoruz
else
    echo "❌ İnşa sırasında hata oluştu."
    exit 1
fi

echo -e "${BLUE}❓ Ayarları Fedora'ya uygulamak (switch) ister misin? (y/n)${NC}"
read -r response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo -e "${BLUE}🚀 Uygulanıyor...${NC}"
    nix run home-manager/release-25.11 -- init --switch --flake .#fluffypal
    echo -e "${GREEN}✨ İşlem tamam!${NC}"
else
    echo -e "${BLUE}👋 Sadece test edildi, hiçbir değişiklik yapılmadı.${NC}"
fi