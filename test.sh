#!/usr/bin/env bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'
git add -N . 

echo -e "${BLUE}🔍 Nix Flake yapısı kontrol ediliyor...${NC}"

# 1. Syntax Kontrolü
if nix flake check; then
    echo -e "${GREEN}✅ Kod yapısı (Syntax) doğru.${NC}"
else
    echo -e "${RED}❌ Kodda hata var!${NC}"
    git reset
    exit 1
fi

echo -e "${BLUE}🛠️  Tüm sistem inşa ediliyor (Dry-run)...${NC}"

# 2. İnşa Testi (Artık nixosConfigurations üzerinden test ediyoruz)
# 'cutie' senin hostname'in, flake.nix ile aynı olmalı
if nix build .#nixosConfigurations.cutie.config.system.build.toplevel --dry-run; then
    echo -e "${GREEN}✅ İnşa başarılı! Hem sistem hem kullanıcı ayarları uyumlu.${NC}"
else
    echo -e "${RED}❌ İnşa başarısız! Mantıksal bir çakışma var.${NC}"
    git reset
    exit 1
fi

echo -e "${BLUE}👋 Test tamamlandı. Her şey kuruluma hazır!${NC}"
git reset