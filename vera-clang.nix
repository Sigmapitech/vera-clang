{ pkgs, system }:
let
  libclang = (import ./libclang.nix { inherit system pkgs; });
  py = pkgs.python310.withPackages (p: [ (libclang p) ]);
in
pkgs.banana-vera.overrideAttrs (prev: {
  nativeBuildInputs = prev.nativeBuildInputs ++ [ pkgs.makeWrapper ];

  postFixup = ''
    wrapProgram $out/bin/vera++ \
      --set PYTHONPATH "${py}/${py.sitePackages}" \
      --set PATH "${pkgs.libffi}/lib"
  '';
})
