{pkgs, ...}: {
  imports = [
    ./diag.nix
  ];
  config = {
    environment.systemPackages = with pkgs; [
      # NETWORKING #
      tcpdump
      # HARDWARE #
      usbutils
      pciutils
    ];
    # add MTR and allow it to do all the permissions setup it needs to properly run
    programs.mtr.enable = true;

    # allow this host to respond to pings
    networking.firewall.allowPing = true;
  };
}
