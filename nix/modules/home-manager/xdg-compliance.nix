{ pkgs, lib, config, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    home = {
      shellAliases = {
        mbsync = "mbsync -c \"$XDG_CONFIG_HOME/isync/mbsyncrc\"";
        yarn = "yarn --use-yarnrc \"$XDG_CONFIG_HOME/yarn/config\"";
      };
      sessionVariables = {
        ANDROID_SDK_HOME = "${config.home.sessionVariables.XDG_CONFIG_HOME}/android";
        ANSIBLE_CONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/ansible/ansible.cfg";
        ANSIBLE_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/ansible";
        CABAL_CONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/cabal/config";
        CABAL_DIR = "${config.home.sessionVariables.XDG_CACHE_HOME}/cabal";
        CARGO_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/cargo";
        CUDA_CACHE_PATH = "${config.home.sessionVariables.XDG_CACHE_HOME}/nv";
        DOCKER_CONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/docker";
        ELM_HOME = "${config.home.sessionVariables.XDG_CACHE_HOME}/elm";
        ERRFILE = "${config.home.sessionVariables.XDG_CACHE_HOME}/X11/xsession-errors";
        GEM_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/gem";
        GEM_SPEC_CACHE = "${config.home.sessionVariables.XDG_CACHE_HOME}/gem";
        GHCUP_USE_XDG_DIRS = "true";
        GNUPGHOME = "${config.home.sessionVariables.XDG_DATA_HOME}/gnupg";
        GOPATH = "${config.home.sessionVariables.XDG_DATA_HOME}/go";
        GRADLE_USER_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/gradle";
        GRIPHOME = "${config.home.sessionVariables.XDG_CONFIG_HOME}/grip";
        # GTK2_RC_FILES = "${config.home.sessionVariables.XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"; # Conflicts with nix built in
        HISTFILE = "${config.home.sessionVariables.XDG_DATA_HOME}/history";
        INPUTRC = "${config.home.sessionVariables.XDG_CONFIG_HOME}/shell/inputrc";
        IPYTHONDIR = "${config.home.sessionVariables.XDG_CONFIG_HOME}/ipython";
        JDK_HOME = "/usr/lib/jvm/default";
        JDTLS_HOME = "/usr/share/java/jdtls";
        KODI_DATA = "${config.home.sessionVariables.XDG_DATA_HOME}/kodi";
        LEIN_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/lein";
        LESSHISTFILE = "-";
        NOTMUCH_CONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/notmuch-config";
        NPM_CONFIG_USERCONFIG = "${config.home.sessionVariables.XDG_CONFIG_HOME}/npm/npmrc";
        NVM_DIR = "${config.home.sessionVariables.XDG_DATA_HOME}/nvm";
        PYLINTHOME = "${config.home.sessionVariables.XDG_CACHE_HOME}/pylint";
        PYTHONSTARTUP = "${config.home.sessionVariables.XDG_CONFIG_HOME}/python/pythonrc";
        ROSWELL_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/roswell";
        RUSTUP_HOME = "${config.home.sessionVariables.XDG_DATA_HOME}/rustup";
        SQLITE_HISTORY = "${config.home.sessionVariables.XDG_DATA_HOME}/sqlite_history";
        STACK_ROOT = "${config.home.sessionVariables.XDG_DATA_HOME}/stack";
        TMUX_TMPDIR = "${config.home.sessionVariables.XDG_STATE_HOME}";
        UNISON = "${config.home.sessionVariables.XDG_DATA_HOME}/unison";
        VSCODE_PORTABLE = "${config.home.sessionVariables.XDG_DATA_HOME}/vscode";
        WGETRC = "${config.home.sessionVariables.XDG_CONFIG_HOME}/wget/wgetrc";
        WINEPREFIX = "${config.home.sessionVariables.XDG_DATA_HOME}/wine";
        ZDOTDIR = "${config.home.sessionVariables.XDG_CONFIG_HOME}/zsh";
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=\"${config.home.sessionVariables.XDG_CONFIG_HOME}/java";
      };
    };
    xdg = {
      configFile = {
        "wget/wgetrc".text = "";
      };
    };
  };
}
