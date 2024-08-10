{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktop.nix
  ];
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
  nix.gc.automatic = false; # disable nix GC because we have nh
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
