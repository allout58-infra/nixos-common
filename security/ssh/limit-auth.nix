{...}: {
  config = {
    services.openssh = {
      settings = {
        PermitRootLogin = "no";
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
      };
      extraConfig = ''
        PubkeyAuthentication yes
        AuthenticationMethods publickey
        PermitEmptyPasswords no
        HostbasedAuthentication no
      '';
    };
  };
}
