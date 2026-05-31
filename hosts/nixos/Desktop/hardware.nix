{ system, ... }:
{
  nixpkgs.hostPlatform = system;
  # Bu dosya NixOS kurulumu sırasında 'nixos-generate-config'
  # tarafından oluşturulan gerçek donanım ayarlarıyla değiştirilecek.
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };
  imports = [ ];
}
