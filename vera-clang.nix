{
  stdenv,
  banana-vera,
  libffi,
  makeWrapper,
  python310,
}:
let
  sharedlibExt = stdenv.hostPlatform.extensions.sharedLibrary;

  pyenv = python310.withPackages (p: [ p.libclang ]);
in
banana-vera.overrideAttrs (prev: {
  nativeBuildInputs = prev.nativeBuildInputs ++ [ makeWrapper ];

  cmakeFlags = (prev.cmakeFlags or []) ++ [
    "-DPython3_EXECUTABLE=${pyenv.interpreter}"
    "-DPython3_INCLUDE_DIR=${pyenv}/include/python3.10"
    "-DPython3_LIBRARY=${pyenv}/lib/libpython3.10${sharedlibExt}"
  ];

  # Bring support for the new boost ABI
  postPatch = ''
    substituteInPlace src/executable_path.cpp \
      --replace-fail "::path(buf).normalize()" "::path(buf).lexically_normal()"
  '';

  postFixup = ''
    wrapProgram $out/bin/vera++ \
      --set PYTHONPATH "${pyenv}/${pyenv.sitePackages}" \
      --set PATH "${libffi}/lib"
  '';
})
