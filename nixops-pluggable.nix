{
  pkgs
}:
let
  overridesXX = import ./overrides.nix {
    inherit (pkgs) lib runCommandNoCC symlinkJoin;
    inherit poetry2nix;
    inherit (pkgs) python38;
  };

  overrides = overridesXX.overrides;
  interpreter = overridesXX.interpreter;
  inherit (pkgs) poetry2nix;
in
  rec {
    nixopsPluggable = interpreter.pkgs.nixops;

    nixops = nixopsPluggable.withPlugins (ps: [
      ps.nixops-hetznercloud
    ]);

    devShell = pkgs.mkShell {
      buildInputs = [
        (poetry2nix.mkPoetryEnv {
          projectDir = ./.;
          inherit overrides;
          python = pkgs.python38;
        })
        pkgs.poetry
        nixops
      ];
    };
  }
