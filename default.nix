{ pkgs ? import <nixpkgs> {} }:

{
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  wlr-sunclock = pkgs.callPackage ./pkgs/wlr-sunclock { };
  mpvpaper = pkgs.callPackage ./pkgs/mpvpaper { };
}

