{
  banana-vera,
  libffi,
  makeWrapper,
  python310,
}:
banana-vera.overrideAttrs (prev: {
  nativeBuildInputs = prev.nativeBuildInputs ++ [ makeWrapper ];

  postFixup = ''
    wrapProgram $out/bin/vera++ \
      --set PYTHONPATH "${python310}/${python310.sitePackages}" \
      --set PATH "${libffi}/lib"
  '';
})
