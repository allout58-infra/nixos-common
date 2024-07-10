{...}: let
  username = "jhollowell";
in {
  config = {
    age.secrets."${username}-email".file = ../secrets/my-email.age;

    users.users."${username}" = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHlvLsl5o1Ln9s7QVqz5eFbymS8Xp34VrznbnOZ789m jhollowell@jth-gaming-desktop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9RPOtkTMqjPR/3LX+XJZfVwtVZAM7NkbGgK+gIZMMN jhollowell@jhollowell-pop-laptop"
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

    programs.git = {
      enable = true;
      userName = "${username}";
      userEmail = "${config.age.secrets.${username} - email.path}";

      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        aliases = {
          co = "checkout";
        };
      };
    };
  };
}
