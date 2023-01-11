# were looking at pkgs/applications/misc/hello default.nix
# explains that .override overrides the top input parameters
# .overrideAttrs is for the attributes inside the mkDerivation


let
  pkgs = import <nixpkgs> {
    overlays = [
      (final: prev: {
        hello = (prev.hello.override {
          fetchurl = throw "not fetchurl";
        }).overrideAttrs (oldAttrs: {
            src = oldAttrs.src;
            nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
              final.jq
          ];
        });
      })
    ]; 
  };
in pkgs.hello
