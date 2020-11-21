let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {
    overlays = [ (import (sources.poetry2nix + "/overlay.nix")) ];
  };
in
  { pkgs ? pkgs,
  }:
(import ./nixops-pluggable.nix { inherit pkgs; }).devShell
