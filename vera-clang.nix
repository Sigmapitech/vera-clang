{ pkgs, system, py }:
pkgs.banana-vera.overrideAttrs (prev: {
  nativeBuildInputs = prev.nativeBuildInputs ++ [ pkgs.makeWrapper ];

  postFixup = ''
    wrapProgram $out/bin/vera++ \
      --set PYTHONPATH "${py}/${py.sitePackages}" \
      --set PATH "${pkgs.libffi}/lib"
  '';
})
