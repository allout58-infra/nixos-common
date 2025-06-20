{config, ...}: let
  username = "jhollowell";
in {
  config = {
    users.users."${username}" = {
      isNormalUser = true;
      description = "James Hollowell";
      extraGroups = ["wheel" "networkmanager" "docker"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHlvLsl5o1Ln9s7QVqz5eFbymS8Xp34VrznbnOZ789m jhollowell@jth-gaming-desktop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9RPOtkTMqjPR/3LX+XJZfVwtVZAM7NkbGgK+gIZMMN jhollowell@jhollowell-pop-laptop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbvXdNDaNhmLQTRZzSU6t6l9HJUVhtLkz4T2j4r6+z4 jhollowell@jhollowell-frmwk"
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBB4fzSF0vl9vmZe5TBqTfEEHjiMGV1C2a4mzuFqWQsn3bwOGGJ8RDk4LuwiwmW2pGrm7TdUTbMEazj9D5jLhle8= swampfox\jhollowell@jhollowell9520"
      ];
    };

    # Make sudo calls not require a password
    security.sudo.extraRules = [
      {
        users = ["${username}"];
        commands = [
          {
            command = "ALL";
            options = ["NOPASSWD" "SETENV"];
          }
        ];
      }
    ];

    # ensure user can run nix commands
    nix.settings.allowed-users = ["${username}"];
  };
}
