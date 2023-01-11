# were looking at pkgs/applications/misc/hello default.nix
# explains that .override overrides the top input parameters
# .overrideAttrs is for the attributes inside the mkDerivation


let
  pkgs = import <nixpkgs> {
    overlays = [
      (final: prev: {
        hello = (prev.hello.override {
          #fetchurl = throw "not fetchurl";
        }).overrideAttrs (finalAttrs: {
          version = "2.12";
          #version = "something-that-doesnt-exist";

          # for now, this is probably the best approach
          src = final.fetchurl {
            url = "mirror://gnu/hello/hello-${finalAttrs.version}.tar.gz";
            sha256 = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA=";
            #sha256 = "0000000000000000000000000000000000000000000000000000";
          };

          #src = finalAttrs.src.overrideAttrs (finalAttrs': {
            #sha256 = "0000000000000000000000000000000000000000000000000000";
            #outputHash = "0000000000000000000000000000000000000000000000000000";
            #outputHash = "";
            #});


            #src = oldAttrs.src;


            nativeBuildInputs = (finalAttrs.nativeBuildInputs or []) ++ [
              final.jq
          ];
        });
      })
    ]; 
  };
in pkgs.hello
