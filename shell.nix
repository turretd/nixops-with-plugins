let
  sources = import ./nix/sources.nix;
  defaultPkgs = import sources.nixpkgs {
    overlays = [ (import (sources.poetry2nix + "/overlay.nix")) ];
  };
in
  { pkgs ? defaultPkgs,
  }:
(import ./nixops-pluggable.nix { inherit pkgs; }).devShell
