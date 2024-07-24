{
  description = "A set of common Nix/NixOS modules for allout58";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  # The release branch of the NixOS/nixpkgs repository on GitHub.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  # It is also possible to "inherit" an input from another input. This is useful to minimize
  # flake dependencies. For example, the following sets the nixpkgs input of the top-level flake
  # to be equal to the nixpkgs input of the nixops input of the top-level flake:
  # inputs.nixpkgs.url = "nixpkgs";
  # inputs.nixpkgs.follows = "nixops/nixpkgs";

  # Work-in-progress: refer to parent/sibling flakes in the same repository
  # inputs.c-hello.url = "path:../c-hello";

  outputs = all @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosModules = {
      env.common = import ./env/common.nix;
      net.firewall = import ./net/firewall.nix;
      net.tailscale = import ./net/tailscale.nix;
      security = {
        ssh.limit-auth = import ./security/ssh/limit-auth.nix;
        audit = import ./security/audit.nix;
      };
      users = import ./users/default.nix;
      workloads = {
        deep-diag = import ./workloads/deep-diag.nix;
        diag = import ./workloads/diag.nix;
        ssh = import ./workloads/ssh.nix;
      };
      secrets = import ./secrets/secrets-export.nix;
      home-manager = {
        jhollowell = import ./home-mgr/jhollowell.nix;
      };
    };

    # format the nix code in this flake
    # alejandra is a nix formatter with a beautiful output
    formatter."${system}" = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
