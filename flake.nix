{
  description = "aoc 2022";

  inputs = {
    # system
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      lib = pkgs.lib;
      stdenv = pkgs.stdenv;
    in {
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [
          ghc
        ];
      };
    };
}
