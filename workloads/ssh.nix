{...}: {
  imports = [
    ../security/ssh/limit-auth.nix
  ];
  config.services.openssh = {
    enable = true;
    openFirwall = true;

    extraConfig = "Protocol 2";
  };
}
