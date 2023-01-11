let
  pkgs = import <nixpkgs> {};
  my_nodejs = pkgs.nodejs-18_x;
in
  pkgs.stdenv.mkDerivation {
    name = "test";
    dontUnpack = true;
    nativeBuildInputs = with pkgs; [
      my_nodejs
    ];
    buildPhase = ''
      node --version > version
    '';
    installPhase = ''
      mv version $out
    '';
    passthru = {
      inherit pkgs;
      shell = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          my_nodejs
        ];
      };
    };
  }
