{
  config,
  pkgs,
  ...
}: let
  # Override discover to add flatpak backend
  discover-wrapped =
    pkgs.symlinkJoin
    {
      name = "discover-flatpak-backend";
      paths = [pkgs.kdePackages.discover];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/plasma-discover --add-flags "--backends flatpak"
      '';
    };
in {
  system.nixos.tags = ["with-plasma6"];
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

  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.kalk
    kdePackages.plasma-vault
    kdePackages.kamoso
    kdePackages.kate
    discover-wrapped # store
  ];
}
