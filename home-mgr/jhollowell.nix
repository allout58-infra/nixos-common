{dotFileRepo}: {
  config,
  pkgs,
  ...
}: {
  home.username = "jhollowell";
  home.homeDirectory = "/home/jhollowell";

  # https://github.com/allout58/dotfiles

  home.file.".vimrc".source = "${dotFileRepo}/.vimrc";
  home.file.".bashrc".source = "${dotFileRepo}/.bashrc";
  # home.file.".gitrc".source = "${dotFileRepo}/.gitrc";

  home.packages = with pkgs; [
    vim
  ];

  programs.git = {
    enable = true;
    userName = "James Hollowell";
    userEmail = "jamesthollowell@gmail.com";

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

    # Adds utility functions to make building PS1 easier
    prompt.enable = true;
  };

  programs.bash = {
    promptInit = ''
          # get current branch in git repo
      function parse_git_branch() {
      	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
      	if [ ! "$\{BRANCH}" == "" ]
      	then
      		STAT=`parse_git_dirty`
      		echo "[$\{BRANCH}$\{STAT}]"
      	else
      		echo ""
      	fi
      }

      # get current status of git repo
      function parse_git_dirty {
      	status=`git status 2>&1 | tee`
      	dirty=`echo -n "$\{status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
      	untracked=`echo -n "$\{status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
      	ahead=`echo -n "$\{status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
      	newfile=`echo -n "$\{status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
      	renamed=`echo -n "$\{status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
      	deleted=`echo -n "$\{status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
      	bits='\'
      	if [ "$\{renamed}" == "0" ]; then
      		bits=">$\{bits}"
      	fi
      	if [ "$\{ahead}" == "0" ]; then
      		bits="*$\{bits}"
      	fi
      	if [ "$\{newfile}" == "0" ]; then
      		bits="+$\{bits}"
      	fi
      	if [ "$\{untracked}" == "0" ]; then
      		bits="?$\{bits}"
      	fi
      	if [ "$\{deleted}" == "0" ]; then
      		bits="x$\{bits}"
      	fi
      	if [ "$\{dirty}" == "0" ]; then
      		bits="!$\{bits}"
      	fi
      	if [ ! "$\{bits}" == "" ]; then
      		echo " $\{bits}"
      	else
      		echo ""
      	fi
      }

      # export PS1="\t \[\e[37m\][\[\e[m\]\[\e[32m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]] \w \[\e[33m\]\`parse_git_branch\`\[\e[m\] \[\e[37m\]\\$\[\e[m\] "
      export PS1="\t \[\e[37m\][\[\e[m\]\[\e[32m\]\u\[\e[m\]@\[\e[32m\]\h\[\e[m\]] \w \[\e[33m\]\`_git_ps1\`\[\e[m\] \[\e[37m\]\\$\[\e[m\] "
    '';
    undistractMe = {
      enable = true;
      playSound = true;
    };
  };

  programs.direnv.enable = true;

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
