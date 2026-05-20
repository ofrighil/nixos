{ config, lib, pkgs, ... }: {
  users.users.ofrighil = {
    isNormalUser = true;
    description = "Eugene";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      vim
    ];
  };

  imports = [
    ../modules/editors
  ];
  
  modules.editors.neovim.enable = true;

  home-manager.users.ofrighil = { config, ... }: 
  {
    programs.home-manager.enable = true;
    home.stateVersion = "23.11";

    # xdg.configFile."nvim".source = ./dotfiles/nvim;
    # xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/home/dotfiles/nvim";
    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/modules/editors/neovim/nvim";
  };
}
