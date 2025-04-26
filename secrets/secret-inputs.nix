rec {
  jth-gaming-desktop-jhollowell = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHlvLsl5o1Ln9s7QVqz5eFbymS8Xp34VrznbnOZ789m jhollowell@jth-gaming-desktop";
  jhollowell-pop-laptop-jhollowell = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9RPOtkTMqjPR/3LX+XJZfVwtVZAM7NkbGgK+gIZMMN jhollowell@jhollowell-pop-laptop";
  jhollowell-frmwk = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMbvXdNDaNhmLQTRZzSU6t6l9HJUVhtLkz4T2j4r6+z4 jhollowell@jhollowell-frmwk";

  allUsers = [jth-gaming-desktop-jhollowell jhollowell-pop-laptop-jhollowell jhollowell-frmwk];

  nix-media = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMcsjNqTqFOGOb7S5pTkjq9VsgFFMqWpw1RIZNdUaMU";

  allSystems = [nix-media];
}
