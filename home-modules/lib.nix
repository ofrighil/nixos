{ config, ... }:
{
  config.lib.dotfiles.mkSymlink =
    dir: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/${dir}";
}
