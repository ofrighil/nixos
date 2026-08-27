{ inputs, pkgs, ... }:
{
  users.users.ofrighil = {
    isNormalUser = true;
    description = "Eugene";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.starship.enable = true;

  home-manager.users.ofrighil =
    { config, pkgs, ... }:
    let
      dotfile = dir: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/${dir}";
    in
    {
      programs.home-manager.enable = true;
      home.stateVersion = "26.05";

      programs.ghostty.enable = true;

      imports = [
        ../home-modules
      ];

      home-modules.editors.emacs.enable = true;
      home-modules.editors.neovim.enable = true;

      home-modules.languages.agda.enable = true;
      home-modules.languages.haskell.enable = true;
      home-modules.languages.nix.enable = true;
      home-modules.languages.ocaml.enable = true;
      home-modules.languages.python.enable = true;
      home-modules.languages.rust.enable = true;

      programs.firefox.enable = true;

      home.packages = with pkgs; [
        git
        fzf
        jujutsu
        ripgrep
        inputs.assets.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      fonts.fontconfig.enable = true;

      xdg.configFile."emacs".source = dotfile "emacs";
      xdg.configFile."ghostty".source = dotfile "ghostty";
      xdg.configFile."hypr".source = dotfile "hypr";
      # xdg.configFile."nvim".source = ./dotfiles/nvim;
      xdg.configFile."nvim".source = dotfile "nvim";
    };
}
