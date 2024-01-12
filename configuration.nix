# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/apple/t2>       # Hardware configuration for MacBook Pro with T2 chip. More details at: https://github.com/NixOS/nixos-hardware
      ./hardware-configuration.nix
      ./pipewire_sink_conf.nix        # Enhanced audio configuration for improved sound quality on the MacBook Pro 2019. See: https://github.com/lemmyg/t2-apple-audio-dsp/tree/speakers_161
      ./pipewire_mic_conf.nix         # Improved microphone configuration for better audio capture on the MacBook Pro 2019. Details at: https://github.com/lemmyg/t2-apple-audio-dsp/tree/mic
      ./nginx.nix                     # Nginx web server configuration. Configuration details available at: https://github.com/TarikSudo/nginx-multidomain-nixos
    ];

  # Integration of WiFi and Bluetooth firmware
  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "brcm-firmware";

      buildCommand = ''
        dir="$out/lib/firmware"
        mkdir -p "$dir"
        cp -r ${./files/firmware}/* "$dir"
      '';
    })
  ];

  # Enabling Intel GPU for improved battery life (up to 3 extra hours)
  hardware.apple-t2.enableAppleSetOsLoader = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "innova"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Configuration of hostnames and their corresponding IP addresses
  networking.extraHosts = ''
    127.0.0.1 localhost
    ::1 localhost
  '';

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.me = { # Replace "me" with your desired username
    isNormalUser = true;
    description = "Me"; # Replace "Me" with your real name or preferred user description
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  # wget
    kate
    chromium
    pkgs.libsForQt5.kdenlive
    pkgs.libsForQt5.kolourpaint
    pkgs.libsForQt5.ksystemlog
    pkgs.libsForQt5.skanpage
    pkgs.vlc
    pkgs.gimp
    pkgs.libreoffice-qt
    pkgs.obs-studio
    pkgs.virtualbox
    pkgs.vscodium
    pkgs.thunderbird
    pkgs.telegram-desktop
    ladspaPlugins
    calf
    lsp-plugins
    pkgs.dbeaver
    pkgs.gnome.gnome-disk-utility
    pkgs.python3

    # Enabling PHP - remove this section if PHP is not required
    (pkgs.php.buildEnv {
      extensions = ({ enabled, all }: enabled ++ (with all; [
        mysqli
        pdo_mysql
      ]));
      extraConfig = ''
        display_errors = On
        date.timezone = Europe/Istanbul
        error_log = /srv/logs/php_errors.log
        error_reporting = E_ALL
        memory_limit = 128M
      '';
    })
    # End of PHP configuration

  ];

  systemd.user.services.pipewire.environment = {
    LADSPA_PATH = "${pkgs.ladspaPlugins}/lib/ladspa";
    LV2_PATH = "${config.system.path}/lib/lv2";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
