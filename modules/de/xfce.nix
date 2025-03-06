# xfce configuration
#
# <https://nixos.wiki/wiki/Xfce>
#
# TODO:
# - Look into using bspwm with xfce
# - Put some stuff (I.E ly and pipewire) into a seperate module
# - Look into using Lemurs (aka write my own package for that)
# - Screenshots with grim
# - Do something about the font

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

  # TODO(Julius): This doesnt seem to work?
  security.pam.services.gdm.enableGnomeKeyring = true;

  services.xserver = {
    enable = true;
    desktopManager.xfce = {
      enable = true;
      # TODO(Julius): Enable Wayland. The main problem right (2025-03-03) now is
      #               that xfwm4 is not ported to Wayland. Which means that I do
      #               not have access to keyboard shortcuts. Which is quite
      #               important to my workflow. Soooo... :(
      enableWaylandSession = false;
    };
  };

  home-manager.users.julius =
    { ... }:
    {
      xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml".source =
        ./xfce_keyboard.xml;
      xdg.configFile."xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml".source = ./xfce_panel.xml;
    };
}
