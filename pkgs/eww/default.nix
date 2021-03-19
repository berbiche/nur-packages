{ lib, rustPlatform, fetchFromGitHub
, makeWrapper, pkg-config, wrapGAppsHook
, gtk3, gdk-pixbuf, glib, gobject-introspection
, udev, cairo, pango, atk
}:

rustPlatform.buildRustPackage rec {
  pname = "eww";
  version = "unstable-2021-03-08";

  src = fetchFromGitHub {
    owner = "elkowar";
    repo = pname;
    rev = "c4cbdedec58d94fe4368da3bd740c07ea7907113";
    hash = "sha256-H1RdKwSqqwU2hJSCaNBp0DXimlhd0DUWUkD3nZYdTvs=";
  };

  cargoHash = "sha256-I5RpC1qP8hJy/F7uDtyBeX1sw46WZtUjS5vfI2yC4EI=";
  # To support nixpkgs-20.09
  cargoSha256 = "sha256-I5RpC1qP8hJy/F7uDtyBeX1sw46WZtUjS5vfI2yC4EI=";

  nativeBuildInputs = [ pkg-config gobject-introspection wrapGAppsHook makeWrapper ];

  # There might be extra unneeded dependencies, I did not test
  buildInputs = [
    gtk3
    gdk-pixbuf
    glib
    udev
    cairo
    pango
    atk
  ];

  # dontPatchELF = true;

  meta = with lib; {
    description = "ElKowar's waky widgets is a standalone widget system for any window manager";
    homepage = "https://github.com/elkowar/eww";
    license = licenses.mit;
    maintainers = with maintainers; [ berbiche ];
    platforms = platforms.unix ++ platforms.darwin;
  };
}
