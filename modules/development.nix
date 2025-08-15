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

    # NOTE(Julius): This isn't *necessary* per se. Buuuuuut since a lot of
    #               projects have a `flake.nix` in their project I get a lot of
    #               errors when they aren't there. So they are.
    nil
    nixd

    (rust-bin.nightly.latest.default.override {
      targets = [ "wasm32-unknown-unknown" ];
    })
    rust-bin.nightly.latest.rust-analyzer
  ];
}
