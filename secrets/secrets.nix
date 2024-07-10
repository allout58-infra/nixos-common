# See https://github.com/ryantm/agenix?tab=readme-ov-file#tutorial for details.
# Key highlights:
# ALways CD to this directory
# To edit or create a new secret:
#   nix run github:ryantm/agenix -- -e "<file to edit/create>.age"
# Any time you make changes to this file, run this command to rekey secrets
#   nix run github:ryantm/agenix -- -r
let
  jth-gaming-desktop-jhollowell = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHlvLsl5o1Ln9s7QVqz5eFbymS8Xp34VrznbnOZ789m jhollowell@jth-gaming-desktop";
  jhollowell-pop-laptop-jhollowell = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9RPOtkTMqjPR/3LX+XJZfVwtVZAM7NkbGgK+gIZMMN jhollowell@jhollowell-pop-laptop";

  allUsers = [jth-gaming-desktop-jhollowell jhollowell-pop-laptop-jhollowell];

  nix-media = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMcsjNqTqFOGOb7S5pTkjq9VsgFFMqWpw1RIZNdUaMU";

  allSystems = [nix-media];
in {
  "tailscale-auth.age".publicKeys = [nix-media] ++ allUsers;
  "my-email.age".publicKeys = [nix-media] ++ allUsers;
}
