{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./xdg-compliance.nix
  ];

  options = {};

  config = {
    home = {
      shellAliases = {
        # General
        sx = "systemctl suspend && exit"; # Suspend and exit
        myip = "curl \"https://api.ipify.org\""; # Get public ip adress
        mkexe = "sudo chmod +x"; # Make executable
        cpy = "wl-copy"; # Copy to clickboard
        ".." = "cd .."; # Move up one directory in shells where that isn't natively supported
        # Replacements for defacto standard tools
        ls = "exa --grid --icons"; # exa (ls)
        ll = "exa --long --icons"; # exa (ls)
        la = "exa --long --all"; # exa (ls)
        l = "exa --grid --across"; # exa (ls)
        tree = "exa --tree --icons"; # exa (ls)
        cd = "z"; # zoxide (cd)
        fzf = "sk"; # fzf (skim)
        grep = "rg --no-line-number"; # ripgrep (grep)
        ps = "procs"; # procs (ps)
        du = "dust"; # dust (du)
        top = "btm"; # bottom (top/htop)
        htop = "btm"; # bottom (top/htop)
        cat = "bat --paging=never --theme=Dracula --style=\"numbers,changes\" --italic-text=always"; # bat (cat)
        ct = "bat --paging=never --theme=Dracula --style=\"plain\" --italic-text=always"; # bat (cat)
        df = "duf"; # duf (df)
        # Git
        g = "git"; # Git
        ga = "git add"; # Git add
        gaa = "git add --all"; # Git add all unstaged changes
        gr = "git remove"; # Git unstage/remove
        gc = "git commit"; # Git commit
        gl = "git log"; # Git log
        gca = "git commit --amend"; # Git ammend
        gp = "git push"; # Git push
        gpl = "git pull"; # Git pull
        gf = "git fetch"; # Git fetch
        gst = "git status"; # Git status
        gsd = "git diff --staged"; # Git show diff (Diff of current staged area)
        grt = "cd \$(git rev-parse --show-toplevel)"; # Jump to the root of the git repository
        gsb = "git switch \$(git branch | sd \"[ |*]\" \"\" | \$FUZZY_FINDER)"; # Git interacitvely switch branche
        grb = "git branch -d \$(git branch | sd \"[ |*]\" \"\" | \$FUZZY_FINDER)"; # Git interacitvely delete branche
        # gsc = "git --no-pager log --pretty=\"%s|%cn|%cr|%h\" | awk -F'|' '{ printf \"%s... by %s, %s (%s)\\n\", \$1=substr(\$1,1,25), \$2, \$3, \$4 }' | sk | /usr/bin/sed -n -r 's/^.*\\((\\w+)\\)\$/\\1/p'"; # Search git commits
        glc = "git show -s --format=%s | cpy";
      };
      sessionVariables = {
        # XDG Env Vars
        XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
        XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
        XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
        XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
        # Colors
        GCC_COLORS = "error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01";
        MANPAGER = "sh -c \\\"col -bx | bat --theme=Dracula -l man -p\\\"";
        # Overwrite certain programs
        FUZZY_FINDER = "sk";
        GIT_EXTERNAL_DIFF = "difft";
      };
    };
    programs = {
      atuin.enableZshIntegration = true;
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        autocd = true;
        completionInit = "
          autoload -Uz compinit
          compinit -d \"${config.home.sessionVariables.XDG_CACHE_HOME}/zsh/zcompdump-\$ZSH_VERSION\"
        ";
        defaultKeymap = "viins";
        history = {
          extended = true;
          ignoreDups = false;
          path = "${config.home.sessionVariables.XDG_STATE_HOME}/zsh_history";
          save = 9999999;
          size = 9999999;
        };
        dotDir = ".config/zsh";
        # TODO keychain
        initExtra = "
          eval \$(keychain --dir \"${config.home.sessionVariables.XDG_CACHE_HOME}/keychain\" --eval --quiet \"${config.home.sessionVariables.MAINSSHKEYFILE}\")
          eval \"\$(starship init zsh)\"
          eval \"\$(zoxide init zsh)\"
          eval \"\$(atuin init zsh)\"
          # TODO figure out if I can set this through home manager
          zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
          zstyle ':completion:*' completions 1
          zstyle ':completion:*' expand prefix suffix
          zstyle ':completion:*' glob 1
          zstyle ':completion:*' insert-unambiguous true
          zstyle ':completion:*' list-colors ''
          zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
          zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
          zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
          zstyle ':completion:*' max-errors 4
          zstyle ':completion:*' menu select=3
          zstyle ':completion:*' original true
          zstyle ':completion:*' preserve-prefix '//[^/]##/'
          zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
          zstyle ':completion:*' squeeze-slashes true
          zstyle ':completion:*' substitute 1
          zstyle ':completion:*' verbose true
          # Enable Ctrl + Backspace to delete word backwards
          bindkey '^H' backward-kill-word
          # Enable deleting last char on a line & going back to the previous one
          bindkey -v '^?' backward-delete-char
          # Enable skipping words with Ctrl + Arrow Keys
          bindkey '^[[1;5D' backward-word
          bindkey '^[[1;5C' forward-word
          # History
          bindkey -M viins '^k' up-line-or-history
          bindkey -M viins '^j' down-line-or-history
          # bindkey -M viins '^r' history-incremental-pattern-search-backward
          # bindkey -M viins '^f' history-incremental-pattern-search-forward
          bindkey -M vicmd '/' history-incremental-pattern-search-backward
          bindkey -M vicmd '?' history-incremental-pattern-search-forward
          bindkey '^z' history-beginning-search-backward
          bindkey '^u' history-beginning-search-forward
          # Beginning/End of line in insert mode
          bindkey '^a' beginning-of-line
          bindkey '^e' end-of-line
          # Get into normal mode
          bindkey -M viins '^g' vi-cmd-mode
          function preexec() {
              # Set the window title
              # The first arg passed to this func is the string of the command the user has entered
              echo -n -e \"\\033]0;\$1\\007\"
          }
          autoload edit-command-line; zle -N edit-command-line
          bindkey -M vicmd ' ' edit-command-line
        ";
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
