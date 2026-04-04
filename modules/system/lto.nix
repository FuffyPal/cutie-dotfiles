{ config, pkgs, lib, ... }:

{
  nixpkgs.hostPlatform = lib.mkForce {
    gcc.arch = "znver3";
    gcc.tune = "znver3";
    system = "x86_64-linux";
  };

  nix.settings = {
    max-jobs = 6;
    cores = 8;
        daemon-nice-priority = 15;
  };
  nixpkgs.config.packageOverrides = pkgs: {
    stdenv = pkgs.stdenv.override (old: {
      extraAttrs = (old.extraAttrs or {}) // {
        NIX_CFLAGS_COMPILE = "-O3 -march=native -flto=auto -fuse-linker-plugin";
        NIX_LDFLAGS = "-flto=auto";
      };
    });
  };
}
