{ pkgs ? import <nixpkgs> {} }:

{
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  mpvpaper = pkgs.callPackage ./pkgs/mpvpaper { };
  wlclock = pkgs.callPackage ./pkgs/wlclock { };
  wlr-sunclock = pkgs.callPackage ./pkgs/wlr-sunclock { };
}

