{
  config,
  pkgs,
  ...
}: {
  config = {
    age.secrets.tailscale-authkey.file = ../secrets/tailscale-auth.age;

    networking.firewall = {
      allowedUDPPorts = [
        config.services.tailscale.port
      ];
      trustedInterfaces = ["tailscale0"];
    };

    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tailscale-authkey.path;
    };
  };
}
