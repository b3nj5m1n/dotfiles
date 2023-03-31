{ pkgs, lib, config, ... }:
{
  imports = [
    ./xdg-compliance.nix
  ];

  options = { };

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
        MANPAGER = "sh -c \"col -bx | bat --theme=Dracula -l man -p\"";
        # Overwrite certain programs
        FUZZY_FINDER = "sk";
        GIT_EXTERNAL_DIFF = "difft";
      };
    };
    programs = {
      zsh = {
        enable = true;
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
