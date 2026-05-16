{ config, pkgs, ... }: {
  users.users.ofrighil = {
    isNormalUser = true;
    description = "Eugene";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  home-manager.users.ofrighil = { pkgs, ... }: {
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";
  };
}
