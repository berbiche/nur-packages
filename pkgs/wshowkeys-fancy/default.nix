{ stdenv, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "wshowkeys-fancy";
  version = "";

  src = null;

  meta = with stdenv.lib; {
    homepage = "https://github.com/YerinAlexey/wshowkeys-fancy";
  };
}
