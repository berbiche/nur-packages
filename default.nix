{ pkgs ? import <nixpkgs> {}
# nixpkgs' rustPlatform with an unstable version of Rust
, rustPlatformNightly ? null
}:

let
  niv = import ./nix/sources.nix;
  nixpkgs-mozilla = import "${niv.nixpkgs-mozilla}/package-set.nix" { inherit pkgs; };
  rustUnstable = 
      nixpkgs-mozilla.rustChannelOf {
        date = "2021-03-19";
        channel = "nightly";
        sha256 = "sha256-s5kOvQk4INy8tvJ3LMvm2f8vg92V9b/xzsW6j5uHHzY=";
      };
  rustPlatform =
    if rustPlatformNightly != null then
      rustPlatformNightly
    else
      # rustc = rust -> https://github.com/mozilla/nixpkgs-mozilla/issues/21
      pkgs.makeRustPlatform { cargo = rustUnstable.cargo; rustc = rustUnstable.rust; };
in
{
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  deadd-notification-center = pkgs.callPackage ./pkgs/deadd-notification-center { };
  # rustUnstable is not exported, the user should `eww.override { rustUnstable = a-rust-package; }`
  eww = pkgs.callPackage ./pkgs/eww { inherit rustPlatform; };
  mpvpaper = pkgs.callPackage ./pkgs/mpvpaper { };
  waylock = pkgs.callPackage ./pkgs/waylock { };
  wlclock = pkgs.callPackage ./pkgs/wlclock { };
  wlr-sunclock = pkgs.callPackage ./pkgs/wlr-sunclock { };
}

