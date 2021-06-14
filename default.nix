{ pkgs ? import <nixpkgs> {}
# nixpkgs' rustPlatform with an unstable version of Rust
, rustPlatformNightly ? null
}:

let
  inherit (pkgs) lib;
  niv = import ./nix/sources.nix;
  rust-overlay = import pkgs.path {
    inherit (pkgs) system;
    overlays = [ (import niv.rust-overlay) ];
  };
  rustUnstable = rust-overlay.rust-bin.nightly.latest;
  rustPlatform =
    if rustPlatformNightly != null then
      rustPlatformNightly
    else
      # rustc = rust -> https://github.com/mozilla/nixpkgs-mozilla/issues/21
      pkgs.makeRustPlatform { cargo = rustUnstable.cargo; rustc = rustUnstable.default; };
in
{
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  eww = pkgs.callPackage ./pkgs/eww { inherit rustPlatform; };
  kinect-audio-setup = pkgs.callPackage ./pkgs/kinect-audio-setup { };
  mpvpaper = pkgs.callPackage ./pkgs/mpvpaper { };
  waylock = pkgs.callPackage ./pkgs/waylock { };
  wlclock = pkgs.callPackage ./pkgs/wlclock { };
  wlr-sunclock = pkgs.callPackage ./pkgs/wlr-sunclock { };
}

