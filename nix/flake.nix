{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nixpkgs-unstable";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      environment.systemPackages =
        [
          # pkgs.neofetch # NOTE: demo
          pkgs.bat
          pkgs.chruby
          pkgs.eza
          pkgs.fd
          pkgs.fzf
          pkgs.go
          pkgs.highlight
          # pkgs.insomnia
          pkgs.jq
          pkgs.neovim
          pkgs.ripgrep
          pkgs.starship
          pkgs.tmux
          pkgs.vifm
          pkgs.vim
          pkgs.zk
          pkgs.zoxide
        ];

      # Auto upgrade nix package and the daemon service.
      # services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
      # security.pam.enableSudoTouchIdAuth = true;

      users.users.abdulwahaabahmed.home = "/Users/abdulwahaabahmed";
      home-manager.backupFileExtension = "bak";
      # nix.configureBuildUsers = true;
      # nix.useDaemon = true;

      system.keyboard.enableKeyMapping = true;
      system.keyboard.remapCapsLockToControl = true;

      system.defaults = {
        dock.autohide = true;
        dock.mru-spaces = false;

        finder.FXPreferredViewStyle = "clmv";
        finder.AppleShowAllExtensions = true;
        finder.CreateDesktop = false;
        finder.ShowPathbar = true;

        NSGlobalDomain._HIHideMenuBar = true;
        NSGlobalDomain."com.apple.keyboard.fnState" = true;
        NSGlobalDomain.InitialKeyRepeat = 15;
        NSGlobalDomain.KeyRepeat = 2;

        menuExtraClock.ShowAMPM = true;

        screencapture.location = "~/Documents/Screenshots";
        screensaver.askForPasswordDelay = 10;

        loginwindow.LoginwindowText = "Hello world!";
      };
      homebrew.enable = true;
      homebrew.taps = [
        "homebrew/core"
        "homebrew/cask"
        "homebrew/services"
        "dimentium/autoraise"
        "felixkratz/formulae"
        "nikitabobko/tap"
        "homebrew/bundle"
      ];

      homebrew.casks = [
        "1password"
        "1password-cli"
        "aerospace"
        "arc"
        "burp-suite-professional"
        "dash"
        "firefox"
        "hammerspoon"
        "iina"
        "insomnia"
        "jordanbaird-ice"
        "meetingbar"
        "monitorcontrol"
        "ngrok"
        "obsidian"
        "ollama"
        "raycast"
        "sf-symbols"
        "zen-browser"
        "font-maple-mono-nf"
        "font-hack-nerd-font"
        "sf-symbols"
        "font-sf-pro"
      ];
      homebrew.brews = [
        "dimentium/autoraise/autoraise"
        "felixkratz/formulae/borders"
        "felixkratz/formulae/sketchybar"
        "node"
        "nvm"
        "pyenv"
        "pyenv-virtualenv"
        "task"
      ];

    };

  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#abdulwahaab
    darwinConfigurations."Abdulwahaabs-MacBook" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.abdulwahaabahmed = import ./home.nix;
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Abdulwahaabs-MacBook".pkgs;
  };
}
