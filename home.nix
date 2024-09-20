{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "vbox";
  home.homeDirectory = "/home/vbox";



  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';


  dconf.settings = {
	"org/gnome/shell" = {
		disable-user-extensions = false;
		enabled-extensions = [
			"trayIconsReloaded@selfmade.pl"
			"Vitals@CoreCoding.com"
			"workspace-indicator@gitlab.gnome.org"
			"window-list@gitlab.gnome.org"
		];
		favorite-apps = [
			"filezilla.desktop"
			"obsidian.desktop"
			"code.desktop"
			"spotify.desktop"
			"telegram.desktop.wrapper"
			"discord.desktop"
			"firefox.desktop"
			"kitty.desktop"
			"zoom.us"
		];
	};
	"org/gnome/desktop/background" = {
		picture-url = "./pictures/1920x1080-aesthetic-glrfk0ntspz3tvxg.jpg";
	};

	 "org/gnome/shell/extensions/vitals" = {
      		show-storage = true;
      		show-voltage = true;
      		show-memory = true;
      		show-fan = true;
      		show-temperature = true;
      		show-processor = true;
      		show-network = true;
         };
  };


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals


    neofetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # Custom pkgs
    discord
    nodejs
    telegram-desktop
    vscode
    ollama
    spotify
    filezilla
    obsidian
    kitty
    zoom-us
  ];

  # To activate gnome dock

  #home-manager.users.vbox = {
#	dconf.settings = {
#		"org/gnome/shell" = {
#			favorite-apps = ["firefox.desktop" "telegram.desktop"];
#		};
#	};
 # };

#
#  home.activation = {
#    setGSettings = ''
#      ${pkgs.dconf} load / < ${pkgs.writeText "dash-to-dock-settings" ''
#        [org/gnome/shell/extensions/dash-to-dock]
#        favorite-apps=['firefox.desktop', 'org.gnome.Terminal.desktop']
#      ''};
#    '';
#  };

 #home.activation.setGSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #  ${pkgs.dconf}/bin/dconf write /org/gnome/shell/extensions/dash-to-dock/favorite-apps "['firefox.desktop', 'org.gnome.Terminal.desktop']"
 # '';

  # basic configuration of git, please change to your own
  #programs.git = {
  #  enable = true;
  #  userName = "David Vovk";
  #  userEmail = "xdlane@protonmail.ch";
  #};


  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
