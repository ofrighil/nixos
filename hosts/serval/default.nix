{ pkgs, inputs, ... }: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  imports = [
    ./hardware.nix
    ../../modules/graphical
    inputs.kalpa.nixosModules.default
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Boot splash screen.
  boot.plymouth.enable = true;
  boot.plymouth.theme = "plymouth-theme-01";
  boot.plymouth.themePackages = [
    inputs.assets.packages.${pkgs.stdenv.hostPlatform.system}.plymouth-theme-01
  ];

  fonts.packages = [ inputs.assets.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  boot.initrd.kernelModules = [ "i915" ];

  # Silent boot so the splash isn't interrupted by kernel/systemd messages.
  boot.consoleLogLevel = 3;
  boot.kernelParams = [
    "quiet"
    "splash"
    "udev.log_level=3"
    "systemd.show_status=auto"
  ];

  networking.hostName = "serval"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  services.tailscale = {
    enable = true;
    openFirewall = true;
    disableUpstreamLogging = true;
    extraSetFlags = [ "--shields-up" ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  kalpa = {
    enable = true;
    latitude = 40.71;
    longitude = -74.01;
    greeter.enable = true;
  };

  console = {
    earlySetup = true;
    font = "${pkgs.uw-ttyp0}/share/consolefonts/CEur_L-Ttyp0Regular30x14.psf.gz";
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [ git gcc gnumake ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  modules.graphical = "hyprland";

  services.upower.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;

  services.fwupd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
