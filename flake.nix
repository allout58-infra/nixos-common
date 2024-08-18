{
  description = "A set of common Nix/NixOS modules for allout58";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  # The release branch of the NixOS/nixpkgs repository on GitHub.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    allout58-dotfiles = {
      url = "github:allout58/dotfiles/main";
      flake = false;
    };
    agenix = {
      url = "github:ryantm/agenix";
      # optional, not necessary for the module
      inputs.nixpkgs.follows = "nixpkgs";
      # optionally choose not to download darwin deps (saves some resources on Linux)
      inputs.darwin.follows = "";
    };
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
    nixpkgs-unstable,
    allout58-dotfiles,
    ...
  }: let
    system = "x86_64-linux";
  in {
    nixosModules = {
      latestNix = {nix.package = nixpkgs-unstable.legacyPackages.nix;};
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
        plasma = import ./workloads/plasma.nix;
      };
      secrets = import ./secrets/secrets-export.nix;
      home-manager = {
        jhollowell = (import ./home-mgr/jhollowell.nix) {dotFileRepo = allout58-dotfiles;};
      };
    };

    # format the nix code in this flake
    # alejandra is a nix formatter with a beautiful output
    formatter."${system}" = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
