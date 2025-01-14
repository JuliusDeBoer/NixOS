# xfce configuration
#
# <https://nixos.wiki/wiki/Xfce>
#
# TODO:
# - Look into using bspwm with xfce

{ ... }:
{
  services.displayManager.ly.enable = true;

  services.xserver.desktopManager.xfce = {
    enable = true;
    enableWaylandSession = true;
  };
}
