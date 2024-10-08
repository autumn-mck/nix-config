{ config, ... }:

{
  environment.sessionVariables = rec {
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";

    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];

    HISTFILE = "${XDG_STATE_HOME}/bash/history";
    LESSHISTFILE = "${XDG_CACHE_HOME}/less/history";
    PASSWORD_STORE_DIR = "${XDG_DATA_HOME}/pass";
    WINEPREFIX = "${XDG_DATA_HOME}/wine";
    CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/nv";
    DVDCSS_CACHE = "${XDG_DATA_HOME}/dvdcss";

    GOPATH = "${XDG_DATA_HOME}/go";
    CARGO_HOME = "${XDG_DATA_HOME}/cargo";
    RUSTUP_HOME = "${XDG_DATA_HOME}/rustup";
    DOCKER_CONFIG = "${XDG_CONFIG_HOME}/docker";
    DOTNET_CLI_HOME = "${XDG_DATA_HOME}/dotnet";
    ELECTRUMDIR = "${XDG_DATA_HOME}/electrum";
    NODE_REPL_HISTORY = "${XDG_DATA_HOME}/node_repl_history";
    NUGET_PACKAGES = "${XDG_CACHE_HOME}/NuGetPackages";
    ANDROID_USER_HOME = "${XDG_DATA_HOME}/android";
    ANDROID_HOME = "${XDG_DATA_HOME}/android/sdk";
    GRADLE_USER_HOME = "${XDG_DATA_HOME}/gradle";
  };

  environment.shellAliases."wget" = "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
}
