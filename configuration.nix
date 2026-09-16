# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }: {

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.will = {
    isNormalUser = true;
    description = "will";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # global packages for now
  programs.firefox.enable = true;
  programs.fish.enable = true;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    typst
    gh
    typstPackages.versatile-apa
    evince
    python313Packages.pytest
    vim
    wget
    nixd
    appimage-run
    neovim
    git
    tealdeer
    tree
    bat
    fzf
  ];

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  xdg.mime.defaultApplications = {
    "applications/pdf" = "org.gnome.Evince.desktop";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
