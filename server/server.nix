{ config, pkgs, lib, ... }:

{
  imports = [
    ./willow.nix
  ];

  options = {
    isServer = lib.mkEnableOption "isServer";
  };

  config = lib.mkIf (config.isServer) {
    environment.systemPackages = with pkgs; [
    ];

    services.fail2ban.enable = true;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    users.users.autumn = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWL5ax9kU1NShcg3o1ORYepLLjfPuekyYSbb8l5RiIU autumn@mck.is"
      ];
    };
  };
}
