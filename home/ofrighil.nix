{ inputs, ... }: {
  users.users.ofrighil = {
    isNormalUser = true;
    description = "Eugene";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.users.ofrighil =
    {
      config,
      osConfig,
      lib,
      pkgs,
      ...
    }:
    let
      dotfile =
        dir: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/dotfiles/${dir}";
      hyprland = osConfig.modules.graphical == "hyprland";
    in
    {
      programs.home-manager.enable = true;
      home.stateVersion = "26.05";

      programs.ghostty.enable = true;

      imports = [ ../home-modules ];

      home-modules.xdg.tidyUserDirs = osConfig.modules.graphical == "hyprland";

      home-modules.editors.emacs.enable = true;
      home-modules.editors.neovim.enable = true;

      home-modules.languages.agda.enable = true;
      home-modules.languages.haskell.enable = true;
      home-modules.languages.lua.enable = true;
      home-modules.languages.nix.enable = true;
      home-modules.languages.ocaml.enable = true;
      home-modules.languages.python.enable = true;
      home-modules.languages.rust.enable = true;
      home-modules.languages.typescript.enable = true;

      home-modules.quickshell.enable = hyprland;

      programs.bash.enable = true;
      programs.starship.enable = true;

      programs.firefox.enable = true;

      home.packages = with pkgs; [
        claude-code
        git
        fd
        fzf
        jujutsu
        ripgrep
        inputs.assets.packages.${pkgs.stdenv.hostPlatform.system}.default
        wl-clipboard
      ];

      fonts.fontconfig.enable = true;

      xdg.configFile."emacs".source = dotfile "emacs";
      xdg.configFile."ghostty".source = dotfile "ghostty";
      xdg.configFile."nvim".source = dotfile "nvim";

      xdg.configFile."hypr" = lib.mkIf hyprland {
        source = dotfile "hypr";
      };
    };
}
