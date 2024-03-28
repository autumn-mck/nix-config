{ home-manager, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "autumn@mck.is";
    userName = "Autumn McKee";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
