# xfce configuration
#
# <https://nixos.wiki/wiki/Xfce>
#
# TODO:
# - Look into using bspwm with xfce
# - Put some stuff (I.E ly and pipewire) into a seperate module
# - Look into using TBSM
# - Screenshots with grim

{ ... }:
{
  services.displayManager.ly.enable = true;

  # Audio stuff
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  services.xserver.desktopManager.xfce = {
    enable = true;
    # TODO(Julius): Enable Wayland. The main problem right (2025-03-03) now is
    #               that xfwm4 is not ported to Wayland. Which means that I do
    #               not have access to keyboard shortcuts. Which is quite
    #               important to my workflow. Soooo... :(
    enableWaylandSession = false;
  };
}
