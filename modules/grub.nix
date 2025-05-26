{ pkgs, ... }:
{
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;

  # TODO(Julius): Allow hosts to choose if they want to enable OS prober
  boot.loader.grub.useOSProber = true;

  boot.loader.efi.canTouchEfiVariables = true;

  # Theme
  stylix.targets.grub.enable = false;

  # YoRHa theme
  boot.loader.grub.theme = "${
    pkgs.fetchFromGitHub {
      owner = "OliveThePuffin";
      repo = "yorha-grub-theme";
      rev = "4d9cd37baf56c4f5510cc4ff61be278f11077c81";
      hash = "sha256-XVzYDwJM7Q9DvdF4ZOqayjiYpasUeMhAWWcXtnhJ0WQ=";
    }
    }/yorha-1920x1080";

  # CrossCode theme
  # boot.loader.grub.theme = "${
  #   (fetchTarball {
  #     url = "https://github.com/krypciak/crossgrub/releases/download/1.0.0/crossgrub.tar.gz";
  #     sha256 = "0v2dhcqip7sh41lk5rfbacmc13qmpqcfzrjpbwidymmzbs6dwlgp";
  #   })
  # }";
}
