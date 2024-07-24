{ config, pkgs, ... }:
# let
  # dotFileRepo = builtins.fetchGit {
  #   url = "https://github.com/allout58/dotfiles";
  #   rev = "ed82212c5923b715384079666a15e62c1cdf846b";
  # };
# in
{
  home.username = "jhollowell";
  home.homeDirectory = "/home/jhollowell";

  # https://github.com/allout58/dotfiles

  # home.file.".vimrc".source = "${dotFileRepo}/.vimrc";
  # home.file.".bashrc".source = "${dotFileRepo}/.bashrc";
  # home.file.".gitrc".source = "${dotFileRepo}/.gitrc";

  home.packages = with pkgs; [
    vim
  ];

  programs.git = {
    enable = true;
    userName = "James Hollowell";
    userEmail.source = "jamesthollowell@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      help.autocorrect = "prompt";
      aliases = {
        co = "checkout";
        cb = "checkout -b";
        graph = "log --graph --abrev-commit --decorate";
      };
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
