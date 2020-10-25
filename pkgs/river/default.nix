{ stdenv, fetchFromGitHub, llvmPackages
, pkgconfig, scdoc, zig
, wayland, wayland-protocols, wlroots, xorg #libX11
, libxkbcommon, libudev, libevdev, pixman, libGL
}:

with stdenv.lib;

let
  zig-master = zig.overrideAttrs (_old: {
    version = "unstable-0.7.0";
    src = fetchFromGitHub {
      owner = "ziglang";
      repo = "zig";
      rev = "4b48fccaddd2f8f840f34779c07ad1fa634d09c5";
      hash = "sha256-GOdK6pzo7FTQzHaB0g6/d/PPwdLIAGWxkytqXCmNlGU=";
    };
  });
in
llvmPackages.stdenv.mkDerivation rec {
  pname = "river";
  version = "unstable-2020-10-24";

  src = fetchFromGitHub {
    owner = "ifreund";
    repo = pname;
    rev = "27b666dbbabb1635fb523445ac154253098f73fd";
    hash = "sha256-QfYydQT8eQVNL/oiuMV8jAP5VU6xn9wQcBnX0zD8lgg=";
  };

  nativeBuildInputs = [ pkgconfig scdoc ];

  buildInputs = [
    zig-master
    wayland
    wayland-protocols
    wlroots
    xorg.libX11
    libxkbcommon
    libudev
    libevdev
    pixman
    libGL
  ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildFlags = [ "release-safe=true" "man-pages=false" "xwayland=true" ];

  preBuild = ''
    # ls -lA
  '';

  HOME = "$TMPDIR";

  buildPhase = ''
    runHook preBuild

    buildFlags="${concatMapStringsSep " " (x: "-D${x}") buildFlags}"

    echo "$buildFlags"

    chmod +x build.zig

    echo zig build $NIX_CFLAGS_COMPILE $buildFlags --prefix $out install
    zig build $NIX_CFLAGS_COMPILE $buildFlags --prefix $out install

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    ls -lA $out

    runHook postInstall
  '';

  meta = with stdenv.lib; {
    description = ''
      A dynamic tiling Wayland compositor that takes inspiration
      from dwm and bspwm.
    '';
    homepage = "https://github.com/ifreund/river";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ berbiche ];
  };
}
