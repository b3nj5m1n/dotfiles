{ pkgs, ... }:
{
  imports = [
    ./neovim.nix
    ./zsh.nix
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      aria # Basically a better wget
      atuin # Save & search shell history
      bat # Better cat (syntax highlighting, etc.)
      bottom # System monitor
      cmatrix # A masterhacker essential
      difftastic # Better diff which understands syntax
      dotter # Dotfile management
      duf # Display disk usage stats in a readable way
      exa # Better ls
      fd # Better find
      git # I mean it's git
      glow # Render markdown in the terminal
      gnumake # You know make
      hyperfine # Benchmark command performance
      jq # Jesus christ it's JSON Bourne
      killall # Kill processes by name
      mlocate # Locate files quickly from cached database of files
      neomutt # TUI email client
      pfetch # Like neofetch but faster and more minimal
      progress # Show progress bar for coreutils
      ripgrep # Very fast grep, searches directory recursively by default
      sd # Move intuitive sed
      skim # Like fzf, but in rust... yeah that's the only reason
      starship # Fast af prompt generator with tons of useful info
      taskwarrior # The endboss of task management
      tealdeer # tldr client
      timewarrior # Companion to taskwarrior which I still have not set up properly
      tmux # Tabs, panes, sessions, etc.
      tokei # Get LOC stats for a directory
      wget # You know this one
      xplr # TUI file explorer
      zoxide # More modern version of z (remember directories, cd into them without specifying full path)
    ];
  };
}
