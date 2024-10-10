{ pkgs, system, pyenv }:
let
  supported-platforms = {
    x86_64-linux = "manylinux2010_x86_64";
    x86_64-darwin = "macosx_10_9_x86_64";
    aarch64-darwin = "macosx_11_0_arm64";
    aarch64-linux = "manylinux2014_aarch64";
  };
in
pyenv.buildPythonPackage rec {
  pname = "libclang";
  version = "18.1.1";
  format = "wheel";

  src = pkgs.python310Packages.fetchPypi {
    inherit pname version format;

    platform = supported-platforms.${system};

    hash = {
      x86_64-linux = "sha256-xTMJHYo7v3RgoAy2wacdqTv/4UjxcsfQOxwx+/iqKgs=";
      x86_64-darwin = "sha256-bxTD8ZRwTl0JdpEI8DGF/Oesrx0a5Luy8wpywkAMt8U=";
      aarch64-darwin = "sha256-g85QRdEBtmmsOObajlh2XxLaLTqvs7m5jYiyhqYJZNg=";
      aarch64-linux = "sha256-VN2pQKSgSRqdFTK/Bx6j7ybm268DtQAO2U3XF06PlZI=";
    }.${system};
  };
}
