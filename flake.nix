{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        vera = (import ./vera-clang.nix { inherit system pkgs; });
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [ vera ];
        };

        formatter = pkgs.nixpkgs-fmt;

        packages = rec {
          default = vera;
          inherit vera;
        };
      });
}
