{ ... }:
{
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;

  # TODO(Julius): Allow hosts to choose if they want to enable OS prober
  boot.loader.grub.useOSProber = true;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.theme = "${
    (fetchTarball {
      url = "https://github.com/krypciak/crossgrub/releases/download/1.0.0/crossgrub.tar.gz";
      sha256 = "0v2dhcqip7sh41lk5rfbacmc13qmpqcfzrjpbwidymmzbs6dwlgp";
    })
  }";
}
