{ config, lib, ... }:
let
  cfg = config.home-modules.xdg;
  home = config.home.homeDirectory;
in
{
  options.home-modules.xdg.tidyUserDirs = lib.mkEnableOption "Collapse XDG user directories into $HOME";

  config = lib.mkIf cfg.tidyUserDirs {
    xdg.userDirs = {
      enable = true;
      createDirectories = false;
      desktop = home;
      documents = home;
      download = "${home}/dl";
      music = home;
      pictures = "${home}/pics";
      projects = "${home}/projects";
      publicShare = home;
      templates = home;
      videos = home;
    };

    xdg.configFile."user-dirs.conf".text = "enabled=False\n";
  };
}
