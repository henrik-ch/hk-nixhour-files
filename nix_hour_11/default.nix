{
  system ? builtins.currentSystem,
  pkgs ? let
    lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    nixpkgs = fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/${lock.nodes.nixpkgs.locked.rev}.tar.gz";
      sha256 = lock.nodes.nixpkgs.locked.narHash;
    };
  in
    import nixpkgs {
      overlays = [];
      config = {};
      inherit system;
    },
}: let
  #  pkgs = import <nixpkgs> {};
  #  my_nodejs = pkgs.nodejs-18_x;
  frontend = ./frontend {inherit pkgs;};
  backend = ./backend {inherit pkgs;};

  package = pkgs.stdenv.mkDerivation {
    name = "test";
    dontUnpack = true;
    nativeBuildInputs = with pkgs; [
      nodejs-18_x
    ];
    buildPhase = ''
      node --version > version
    '';
    installPhase = ''
      mv version $out
    '';
    passthru = {
      inherit pkgs shell;
    };
  };

  shell = pkgs.mkShell {
    inputsFrom = [
      package
    ];

    packages = [
      pkgs.neovim
    ];

    foo = "baz";

    shellHook = ''
      echo "Welcome to the dev environment!"
      #export foo=bar
    '';
  };
in
  package
