{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    clang-tools
    gnumake
    httpie
    nodejs
    pnpm
    sdcc
  ];
}
