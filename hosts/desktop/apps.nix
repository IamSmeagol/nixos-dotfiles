{ pkgs, ... }: {

  programs.thunderbird.enable = true;
  environment.systemPackages = with pkgs; [
    discord-canary
    kdePackages.dolphin
    keyd
    solaar
    signal-desktop
    burpsuite
    godot
    lmms-full
    xwayland-satellite
    darktable
    pavucontrol
    alacritty
    xclip
    copyq # clipboard history
    cdemu-daemon
    cdemu-client

  ];
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

}
