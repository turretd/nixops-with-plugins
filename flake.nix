{
  description = "NixOps with several plugins installed.";

  # with nixos-20.03 it builds. Doesn't with nixos-20.09 even
  # with python fixed to 3.7.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.03"; 
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
