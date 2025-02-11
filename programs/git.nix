{
  home-manager,
  lib,
  config,
  ...
}:

{
  options = {
    git.enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf (config.git.enable) {
    programs.git = {
      enable = true;
      userEmail = "autumn@mck.is";
      userName = "Autumn McKee";
      extraConfig = {
        init.defaultBranch = "main";
        # http.sslVerify = false; # occasionally needed when cloning stuff from EEECS gitlab
      };
    };
  };
}
