{lib, ...}: {
  config.networking.firewall = {
    allowPing = true;
    enable = lib.mkDefault true;
  };
}
