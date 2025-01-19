{ lib, pkgs, config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  options = {
    forgejo.enable = lib.mkEnableOption "forgejo.enable";
  };

  config = lib.mkIf (config.forgejo.enable) {
    services.caddy = {
      virtualHosts."${toString srv.DOMAIN}" = {
        extraConfig = ''
          reverse_proxy localhost:${toString srv.HTTP_PORT}
          request_body {
            max_size 512MB
          }
        '';
      };
    };

    services.forgejo = {
      enable = true;
      package = pkgs.forgejo;
      database.type = "postgres";
      # Enable support for Git Large File Storage
      lfs.enable = true;
      settings = {
        server = {
          DOMAIN = "git.mck.is";
          # You need to specify this to remove the port from URLs in the web UI.
          ROOT_URL = "https://${srv.DOMAIN}/";
          HTTP_PORT = 3001;
        };
        # You can temporarily allow registration to create an admin user.
        service.DISABLE_REGISTRATION = true;
        # Add support for actions, based on act: https://github.com/nektos/act
        actions = {
          ENABLED = true;
          DEFAULT_ACTIONS_URL = "github";
        };

        ui = {
          DEFAULT_THEME = "macchiato";
          THEMES = "macchiato, forgejo-auto, forgejo-light, forgejo-dark, gitea-auto, gitea-light, gitea-dark, forgejo-auto-deuteranopia-protanopia, forgejo-light-deuteranopia-protanopia, forgejo-dark-deuteranopia-protanopia, forgejo-auto-tritanopia, forgejo-light-tritanopia, forgejo-dark-tritanopia";
        };

        # Sending emails is completely optional
        # You can send a test email from the web UI at:
        # Profile Picture > Site Administration > Configuration >  Mailer Configuration 
        # mailer = {
        #   ENABLED = true;
        #   SMTP_ADDR = "mail.example.com";
        #   FROM = "noreply@${srv.DOMAIN}";
        #   USER = "noreply@${srv.DOMAIN}";
        # };
      };
      # mailerPasswordFile = config.age.secrets.forgejo-mailer-password.path;
    };

    # age.secrets.forgejo-mailer-password = {
    #   file = ../secrets/forgejo-mailer-password.age;
    #   mode = "400";
    #   owner = "forgejo";
    # };
  };
}
