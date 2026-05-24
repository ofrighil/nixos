{
  users.users.ofrighil = {
    isNormalUser = true;
    description = "Eugene";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  imports = [ ../home-modules/common.nix ];

  home-manager.users.ofrighil = { config, pkgs, ... }: 
  {
    programs.home-manager.enable = true;
    home.stateVersion = "26.05";

    imports = [
      ../home-modules
    ];
    
    home-modules.editors.neovim.enable = true;

    home-modules.languages.haskell.enable = true;
    home-modules.languages.nix.enable = true;
    home-modules.languages.python.enable = true;
    home-modules.languages.rust.enable = true;

    programs.firefox.enable = true;

    home.packages = with pkgs; [
      git
      jujutsu
    ];

    # xdg.configFile."nvim".source = ./dotfiles/nvim;
    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/home-modules/editors/neovim/nvim";
  };
}
