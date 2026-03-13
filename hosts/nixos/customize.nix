{ config, pkgs, lib, ... }:

{
  environment.etc."pix-logo.png".source = ../../assets/images/logo.png;

  environment.systemPackages = [
    (pkgs.runCommand "pix-logo-icon" {} ''
      mkdir -p $out/share/pixmaps
      cp ${../../assets/images/logo.png} $out/share/pixmaps/pix-logo.png
    '')
  ];

  boot.plymouth.logo = ../../assets/images/logo5.png;

  environment.etc."os-release".text = lib.mkForce ''
    NAME="Pix"
    ID=pix
    ID_LIKE=nixos
    PRETTY_NAME="Pix OS Flowery Edition"
    VERSION="0.1"
    VERSION_ID="0.1"
    HOME_URL="https://links.fluffypal.me/@fluffypal"
    SUPPORT_URL="https://gitlab.com/FluffyPal/Pal_linux"
    BUG_REPORT_URL="https://gitlab.com/FluffyPal/Pal_linux/issues"
    LOGO="pix-logo"
    DISTRIB_ID=pix
    DISTRIB_RELEASE=0.1
    DISTRIB_DESCRIPTION="Pix OS Flowery Edition (Independent Nix-based Distro)"
  '';
}
