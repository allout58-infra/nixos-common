{pkgs, ...}: {
  # Enable the Docker service
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # Install docker-compose
  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  # Add the user 'jhollowell' to the 'docker' group
  users.users.jhollowell.extraGroups = ["docker"];
}
