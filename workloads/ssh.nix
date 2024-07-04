{...}: {
  imports = [
    ../security/ssh/limit-auth.nix
  ];
  config.services.openssh = {
    enable = true;
    openFirewall = true;

    extraConfig = "Protocol 2";
  };
}
