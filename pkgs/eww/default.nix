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
    rev = "61e42c9c8acb53dbd2eb83ae1f5a946dabede75f";
    hash = "sha256-pipYAd+XVvWd2M/3eDf6XrLoSC2kMTxIXIzYx6HnBeg=";
  };

  cargoHash = "sha256-z8pbJTulkX7faKSIWPaUxvSn1W//qHlaYHWRJD2QUto=";
  # To support nixpkgs-20.09
  cargoSha256 = "sha256-z8pbJTulkX7faKSIWPaUxvSn1W//qHlaYHWRJD2QUto=";

  # Broken test upstream until https://github.com/elkowar/eww/pull/189 is merged
  checkFlags = [ "--skip=config::eww_config::test::test_merge_includes" ];

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
