# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/lenovo/thinkpad/x220"
      ./hardware-configuration.nix
     # ./apps/vim
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  #time.timeZone = "Europe/Madrid";
  services.automatic-timezoned.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
        defaultSession = "none+i3";
    };
  windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
        i3-gaps
     ];
    };
  };

  # Enable the XFCE Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "es";
    xkbVariant = "dvorak";
  };
  
  services.picom = {
    enable = true;
    vSync = true;
    backend = "glx";
    #fade = true;
    opacityRules = ["100:fullscreen" 
                    "95:class_g = 'kitty' && focused"
		    "65:class_g = 'kitty' && !focused"];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  services.blueman.enable = true;

  # Enable Bluetooth
 # hardware.bluetooth.enable = true; # enables support for Bluetooth
 # hardware.bluetooth.powerOnBoot = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "le";
        Experimental = true;
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pob = {
    isNormalUser = true;
    description = "Pablo Muela Martínez";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    file
    anydesk
    obsidian
    google-drive-ocamlfuse
    gnumake
    vim
    R
    pcmanfm
    libreoffice
    vscode
    xclip
    ffmpeg_6-full
    mpv
    alsa-utils
    obs-studio
    bc
    signal-desktop
    rstudio
    darktable
    gparted
    feh
    cmake
    vlc
    zsh
    git
    zsh-autosuggestions
    kitty
    xterm   
    telegram-desktop
    firefox 
    thunderbird
    picom
    neofetch
    pywal
    htop
    killall
    zip
    unzip
    imagemagick
    nix-prefetch-github
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '';
  # List packages installed in system profile. To search, run:
  # $ nix search wget

environment.systemPackages = with pkgs; [
   (python3.withPackages(ps: with ps; [ 
	pyperclip
	pynput
	colorama
	h5py
        pynvim
        jedi
        jedi-language-server
        scipy
        pandas 
	msgpack
	requests
	ps.python-lsp-server
	pylsp-mypy 	
   ]))
   pkgs.vimPlugins.lazy-nvim
   pkgs.vimPlugins.coc-pyright
   pkgs.vimPlugins.pywal-nvim
   pkgs.vimPlugins.deoplete-jedi
   pkgs.vimPlugins.deoplete-nvim
   wget
   (vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      bbenoist.nix
      ms-python.python
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.47.2";
        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      }
    ];
  })
   #(import ./apps/vim/vim.nix)
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
programs.zsh = {
  enable = true;
  autosuggestions.enable = true;
  enableCompletion = true;
  shellAliases = {
    update = "sudo nixos-rebuild switch";
    vim = "nvim";
  };
  histSize = 10000;
  ohMyZsh = {
    enable = true;
    plugins = [ "sudo" "web-search" ];
    theme = "bira";
  };
};

programs.neovim = {
  enable = true;
  defaultEditor = true;
  configure = {
    customRC = ''
      set number relativenumber
      syntax on
      colorscheme pywal
      let g:python3_host_prog = "/run/current-system/sw/bin/python3"
      let g:deoplete#enable_at_startup = 1
      '';
    packages.myVimPackage = with pkgs.vimPlugins; {
      start = [ctrlp pywal-nvim deoplete-nvim 
               deoplete-jedi vim-nix nerdcommenter 
               nerdtree jedi-vim];
    };
  };  
};



programs.steam.enable = true;


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
