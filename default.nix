{ pkgs ? import <nixpkgs> {} }:

{
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  mpvpaper = pkgs.callPackage ./pkgs/mpvpaper { };
  river = pkgs.callPackage ./pkgs/river { };
  waylock = pkgs.callPackage ./pkgs/waylock { };
  wlclock = pkgs.callPackage ./pkgs/wlclock { };
  wlr-sunclock = pkgs.callPackage ./pkgs/wlr-sunclock { };
}

