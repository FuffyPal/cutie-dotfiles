{ pkgs, ... }:

{
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
    settings = {
      apply_nice = true;
      apply_latencies = true;
      apply_sched = true;
      apply_io = true;
      apply_cgroup = false; 
      
      log_level = "warn";
    };
    extraRules = [
    ];
    extraTypes = [
    ];
    extraCgroups = [
    ];
  };
}