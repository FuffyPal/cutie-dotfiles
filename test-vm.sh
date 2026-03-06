#!/usr/bin/env bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

git add -N .

echo -e "${BLUE}🔍 Nix Flake yapısı kontrol ediliyor...${NC}"

if nix flake check; then
    echo -e "${GREEN}✅ Kod yapısı (Syntax) doğru.${NC}"
else
    echo -e "${RED}❌ Kodda hata var!${NC}"
    git reset
    exit 1
fi

echo -e "${BLUE}🖥️  NixOS VM imajı build ediliyor...${NC}"

if nix build .#nixosConfigurations.cutie.config.system.build.vm; then
    echo -e "${GREEN}✅ VM imajı başarıyla build edildi.${NC}"
    echo
    echo -e "${BLUE}➡️  Sanal makineyi başlatmak için:${NC}"
    echo -e "   ${GREEN}./result/bin/run-nixos-vm${NC}"
    echo
    echo -e "${BLUE}📝 VM içinde sistemi test edebilirsin. İşin bitince VM penceresini kapatman yeterli.${NC}"
else
    echo -e "${RED}❌ VM imajı build edilemedi!${NC}"
    git reset
    exit 1
fi

git reset


