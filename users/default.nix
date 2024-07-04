{...}: {
  imports = [
    ./jhollowell.nix
  ];

  config = {
    # completely recreate /etc/passwd and /etc/groups on rebuild
    users.mutableUsers = false;

    # let users in the `wheel` group run nix commands
    nix.settings.allowed-users = ["@wheel"];
  };
}
