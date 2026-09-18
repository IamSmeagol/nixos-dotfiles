{
  config,
  pkgs,
  host,
  ...
}:

let
  configs = {
    tmux = "tmux";
    qtile = "qtile";
    nvim = "nvim";
    alacritty = "alacritty";
    espanso = "espanso";
  };
  aliases = {
    btw = "echo i use nixos btw";
    build = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles";
    update = "nix flake update --flake ~/nixos-dotfiles";
    upgrade = "update && build";
    waylandcraft = "prismlauncher --launch 26.1.2-wayland-craft";
  };

  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.username = "will";
  home.homeDirectory = "/home/will";
  home.stateVersion = "25.11";

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Smeagol";
        email = "thesmeagol360@gmail.com";
      };
    };
  };

  programs.zoxide.enable = true;
  programs.zoxide.options = [ "--cmd cd" ];
  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };

  programs.fish = {
    enable = true;
    shellAliases = aliases;
    functions.espanso-toggle = ''
      if systemctl --user is-active --quiet espanso
          systemctl --user stop espanso
      else
          systemctl --user start espanso
      end
    '';
  };

  programs.rofi.enable = true;
  programs.rofi.theme = "${pkgs.rofi}/share/rofi/themes/Arc-Dark.rasi";

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    fd
    cargo
    pandoc
    jq
    lazygit
    btop-rocm
    duf
    tldr
    tree-sitter
    unzip
    rofi
    flameshot
    jellyfin-desktop
    handbrake
    vlc
    makemkv
    abcde
    flac
    wine
    ddrescue
    ffmpeg-full
    prismlauncher
    nmap
    fish
    maim
    octaveFull
    spotify
    libreoffice-qt
    hunspell
    hunspellDicts.en_US
    libratbag
    piper
    xdotool
    tmux
  ];
}
