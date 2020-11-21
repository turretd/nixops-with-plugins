{
  description = "NixOps with several plugins installed.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.utils.url = "github:numtide/flake-utils";

  inputs.poetry2nix-src.url = "github:nix-community/poetry2nix";
  inputs.poetry2nix-src.inputs.nixpkgs.follows = "nixpkgs";

  outputs = {nixpkgs, utils, poetry2nix-src, self}: utils.lib.eachDefaultSystem (system: let

    pkgs = import nixpkgs { inherit system; overlays = [ poetry2nix-src.overlay ]; };
    
  in
    {
      defaultPackage = import ./default.nix { inherit pkgs; };
      devShell = import ./shell.nix { inherit pkgs; };
    });
}
