{
  home-manager,
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    vscode.enable = lib.mkEnableOption "vscode";
  };

  config = lib.mkIf (config.vscode.enable) {
    programs.vscode.enable = true;
    programs.vscode.profiles.default = {
      # sandboxes vscode, which allows extensions to work without additional configuration,
      # but as a result prevents elevated permissions from being used in the terminal (e.g. sudo)
      # (might look at this again later, but commented out is fine for now)
      #package = pkgs.vscode.fhs;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons

        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit

        mhutchie.git-graph

        esbenp.prettier-vscode

        github.copilot

        coolbear.systemd-unit-file
        jnoortheen.nix-ide
        unifiedjs.vscode-mdx
        astro-build.astro-vscode
        rust-lang.rust-analyzer
        ms-azuretools.vscode-docker
        tamasfe.even-better-toml
        bierner.comment-tagged-templates
        vscjava.vscode-java-pack
        redhat.java
        ms-python.python
        ms-python.vscode-pylance
        tomoki1207.pdf
        tamasfe.even-better-toml
      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Macchiato";
        "workbench.iconTheme" = "catppuccin-macchiato";

        "editor.tabSize" = 2;
        "editor.insertSpaces" = false;
        "editor.inlineSuggest.enabled" = true;
        "editor.renderWhitespace" = "trailing";
        "editor.formatOnSave" = true;
        "editor.wordWrap" = "on";

        "terminal.external.linuxExec" = "kitty";
        "terminal.integrated.defaultProfile.linux" = "fish";
        "window.menuBarVisibility" = "toggle";
        "window.customTitleBarVisibility" = "never";
        "window.titleBarStyle" = "native";

        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "prettier.printWidth" = 100;
        "prettier.bracketSameLine" = true;
        "prettier.useTabs" = true;

        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;

        "explorer.confirmDragAndDrop" = false;

        "MATLAB.showFeatureNotAvailableError" = false;

        "java.home" = "/run/current-system/sw/lib/openjdk";
        "redhat.telemetry.enabled" = false;

        "python.analysis.typeCheckingMode" = "basic";

        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };

        "[toml]" = {
          "editor.defaultFormatter" = "tamasfe.even-better-toml";
        };

        "[astro]" = {
          "editor.defaultFormatter" = "astro-build.astro-vscode";
        };
      };
    };
  };
}
