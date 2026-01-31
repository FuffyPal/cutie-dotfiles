{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [ pkgs.OVMFFull.fd ];
      };
    };
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  programs.virt-manager.enable = true;

  programs.dconf.enable = true;

  services.spice-vdagentd.enable = true;

  environment.systemPackages = with pkgs; [
    virt-viewer
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];
}
