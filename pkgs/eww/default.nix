{ lib, rustPlatform, fetchFromGitHub
, pkg-config, wrapGAppsHook
, gtk3, gdk-pixbuf, glib, gobject-introspection
, udev, cairo, pango, atk
}:

rustPlatform.buildRustPackage rec {
  pname = "eww";
  version = "unstable-2021-06-02";

  src = fetchFromGitHub {
    owner = "elkowar";
    repo = pname;
    rev = "61e42c9c8acb53dbd2eb83ae1f5a946dabede75f";
    hash = "sha256-pipYAd+XVvWd2M/3eDf6XrLoSC2kMTxIXIzYx6HnBeg=";
  };

  cargoHash = "sha256-Db5o2G9zaf+ZgEt915614qVNw1CwZwFZg9pWjQ2+QGc=";
  cargoSha256 = "${cargoHash}";

  # Broken test upstream until https://github.com/elkowar/eww/pull/189 is merged
  checkFlags = [ "--skip=config::eww_config::test::test_merge_includes" ];

  nativeBuildInputs = [ pkg-config gobject-introspection wrapGAppsHook ];

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

  meta = with lib; {
    description = "ElKowar's waky widgets is a standalone widget system for any window manager";
    homepage = "https://github.com/elkowar/eww";
    license = licenses.mit;
    maintainers = with maintainers; [ berbiche ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
