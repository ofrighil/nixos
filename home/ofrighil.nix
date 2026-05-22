{ config, lib, pkgs, ... }: {
  users.users.ofrighil = {
    isNormalUser = true;
    description = "Eugene";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  home-manager.users.ofrighil = { config, ... }: 
  {
    programs.home-manager.enable = true;
    home.stateVersion = "26.05";

    imports = [
      ../home-modules/editors
    ];
    
    home-modules.editors.neovim.enable = true;

    # xdg.configFile."nvim".source = ./dotfiles/nvim;
    # xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/home/dotfiles/nvim";
    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/home-modules/editors/neovim/nvim";
  };
}
