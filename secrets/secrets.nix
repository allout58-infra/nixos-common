# See https://github.com/ryantm/agenix?tab=readme-ov-file#tutorial for details.
# Key highlights:
# ALways CD to this directory
# To edit or create a new secret:
#   nix run github:ryantm/agenix -- -e "<file to edit/create>.age"
# Any time you make changes to this file, run this command to rekey secrets
#   nix run github:ryantm/agenix -- -r
let
  inputs = import ./secret-inputs.nix;
in {
  "tailscale-auth.age".publicKeys = [inputs.nix-media] ++ inputs.allUsers;
  "my-email.age".publicKeys = inputs.allSystems ++ inputs.allUsers;
  "cloudflare-dns-challenge.age".publicKeys = [inputs.nix-media] ++ inputs.allUsers;
}
