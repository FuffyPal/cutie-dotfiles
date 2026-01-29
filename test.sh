#!/usr/bin/env bash

# Renkler
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔍 Nix Flake yapısı kontrol ediliyor...${NC}"
git add -N .

# 1. Syntax Kontrolü
if nix flake check; then
    echo -e "${GREEN}✅ Kod yapısı (Syntax) doğru.${NC}"
else
    echo -e "${RED}❌ Kodda hata var, lütfen yukarıdaki mesajı incele.${NC}"
    exit 1
fi

echo -e "${BLUE}🛠️  Test amaçlı inşa ediliyor (Dry-run)...${NC}"

# 2. İnşa Testi (Kullanıcı konfigürasyonu için)
if nix build .#homeConfigurations.fluffypal.activationPackage --dry-run; then
    echo -e "${GREEN}✅ İnşa başarılı! (Sistem bu konfigürasyonu kabul ediyor)${NC}"
else
    echo -e "${RED}❌ İnşa başarısız! Mantıksal bir hata var.${NC}"
    exit 1
fi

echo -e "${BLUE}👋 Test tamamlandı. Hiçbir sistem dosyası değiştirilmedi.${NC}"
git reset