{pkgs, ...}: {
  imports = [
    # ./neovim.nix
    ./zsh.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      aria # Basically a better wget
      atuin # Save & search shell history
      bat # Better cat (syntax highlighting, etc.)
      bottom # System monitor
      cmatrix # A masterhacker essential
      difftastic # Better diff which understands syntax
      direnv # Automatically load env variables when entering directory
      doctl # Digital ocean cli
      dotter # Dotfile management
      du-dust # More intuitive du
      duf # Display disk usage stats in a readable way
      eza # Better ls
      fd # Better find
      ffmpeg-full # Video (& audio) transcoding, scaling, etc.
      figlet # Almost as important as toilet
      file # Get information about what kind of file you're looking at
      git # I mean it's git
      glow # Render markdown in the terminal
      gnumake # You know make
      helix # Like neovim but less config
      hexdino # Hex editor
      hexyl # View binary files
      hyperfine # Benchmark command performance
      inotify-tools # Watch for file changes
      jq # Jesus christ it's JSON Bourne
      just # Like make but easier
      killall # Kill processes by name
      libqalculate # qalc cli
      mlocate # Locate files quickly from cached database of files
      mmv-go # Rename files using $EDITOR
      neomutt # TUI email client
      parallel # GNU parallel
      pfetch # Like neofetch but faster and more minimal
      pmount # Easier mounting
      progress # Show progress bar for coreutils
      rage # Rust version of age (actually good encryption)
      ripgrep # Very fast grep, searches directory recursively by default
      sd # Move intuitive sed
      skim # Like fzf, but in rust... yeah that's the only reason
      smartmontools # Monitor S.M.A.R.T. values
      sops # Secret management
      sqlite # Sqlite cli
      starship # Fast af prompt generator with tons of useful info
      taskwarrior # The endboss of task management
      tealdeer # tldr client
      timewarrior # Companion to taskwarrior which I still have not set up properly
      tmux # Tabs, panes, sessions, etc.
      toilet # Almost as important as figlet
      tokei # Get LOC stats for a directory
      unzip # Unzips zips
      wget # You know this one
      xplr # TUI file explorer
      yt-dlp # Download youtube videos
      zellij # Sort of a little bit like tmux
      zoxide # More modern version of z (remember directories, cd into them without specifying full path)
      zstd # Compression
    ];
  };
}
