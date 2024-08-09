{
  pkgs,
  lib,
  ...
}: {
  config = {
    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    nix.gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "monthly";
      options = lib.mkDefault "--delete-older-than 30d";
    };

    # Enable experimental features in Nixpkgs.
    nix.settings = {
      # Manual optimise storage: nix-store --optimise
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };

    # Adds utility functions to make building PS1 easier
    programs.git.prompt.enable = true;

    programs.bash = {
      promptInit = "PS1=\"\t \[\e[37m\][\[\e[m\]\[\e[32m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]] \w \[\e[33m\]\`_git_ps1\`\[\e[m\] \[\e[37m\]\\$\[\e[m\] \"";
      undistractMe = {
        enable = true;
        playSound = true;
      };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      vim
      curl
      git
    ];

    environment.variables.EDITOR = "vim";
  };
}
