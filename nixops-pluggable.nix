{
  pkgs
}:
let
  overridesXX = import ./overrides.nix {
    inherit (pkgs) lib runCommandNoCC symlinkJoin;
    inherit poetry2nix;
  };

  overrides = overridesXX.overrides;
  interpreter = overridesXX.interpreter;
  inherit (pkgs) poetry2nix;
in
  rec {
    nixopsPluggable = interpreter.pkgs.nixops;

    nixops = nixopsPluggable.withPlugins (ps: [
      ps.nixops-aws
      ps.nixops-virtd
      ps.nixopsvbox
      ps.nixops-digitalocean
      ps.nixops-gcp
      ps.nixops-proxmox
    ]);

    devShell = pkgs.mkShell {
      buildInputs = [
        (poetry2nix.mkPoetryEnv {
          projectDir = ./.;
          inherit overrides;
        })
        pkgs.poetry
      ];
    };
  }
