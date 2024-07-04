{pkgs, ...}: {
  config = {
    environment.systemPackages = with pkgs; [
      # NETWORKING #
      dig
      traceroute
      iputils
      # TEXT AND TERMINAL #
      tmux
      vim
      # PERFORMANCE ANALYTICS #
      btop
      htop
      iftop
    ];

    # allow this host to respond to pings
    networking.firewall.allowPing = true;
  };
}
