{ config, pkgs, ... }:

{
  imports = [
    ./rowan/rowan.nix
  ];

  environment.systemPackages = with pkgs; [
  ];

  programs.fish.enable = true;

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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWL5ax9kU1NShcg3o1ORYepLLjfPuekyYSbb8l5RiIU weird@autumn.is"
    ];
  };
}
