#!/usr/bin/env bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'
git add -N .

echo -e "${BLUE}🔍 Nix Flake yapısı kontrol ediliyor...${NC}"

if nix flake check --extra-experimental-features "nix-command flakes"; then
    echo -e "${GREEN}✅ Kod yapısı (Syntax) doğru.${NC}"
else
    echo -e "${RED}❌ Kodda hata var!${NC}"
    git reset
    exit 1
fi

echo -e "${BLUE}🛠️  Tüm sistem inşa ediliyor (Dry-run)...${NC}"

if nix build .#nixosConfigurations.cutie.config.system.build.toplevel --extra-experimental-features "nix-command flakes" --dry-run; then
    echo -e "${GREEN}✅ İnşa başarılı! Hem sistem hem kullanıcı ayarları uyumlu.${NC}"
else
    echo -e "${RED}❌ İnşa başarısız! Mantıksal bir çakışma var.${NC}"
    git reset
    exit 1
fi

if nix build .#nixosConfigurations.retrex.config.system.build.toplevel --extra-experimental-features "nix-command flakes" --dry-run; then
    echo -e "${GREEN}✅ İnşa başarılı! Hem sistem hem kullanıcı ayarları uyumlu.${NC}"
else
    echo -e "${RED}❌ İnşa başarısız! Mantıksal bir çakışma var.${NC}"
    git reset
    exit 1
fi

if nix build .#homeConfigurations."flaouve".activationPackage --extra-experimental-features "nix-command flakes" --dry-run; then
    echo -e "${GREEN}✅ flaouve@it: İnşa başarılı! Home Manager dotfile ayarları uyumlu.${NC}"
else
    echo -e "${RED}❌ flaouve@it: İnşa başarısız! Home Manager ayarlarında çakışma var.${NC}"
    git reset
    exit 1
fi

echo -e "${BLUE}👋 Test tamamlandı. Her şey kuruluma hazır!${NC}"
git reset
