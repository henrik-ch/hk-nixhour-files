# were looking at pkgs/applications/misc/hello default.nix
# explains that .override overrides the top input parameters
# .overrideAttrs is for the attributes inside the mkDerivation


let
  pkgs = import <nixpkgs> {
    overlays = [
      (final: prev: {
        hello = (prev.hello.overrideAttrs (finalAttrs: {
          version = "2.12";
          #version = "something-that-doesnt-exist";

          # for now, this is probably the best approach
          src = final.fetchFromGitHub {
            owner = "infinisil";
            repo = "system";
            rev = "aca2048b0b3360700dfed1a12ade4500383a3547";
            #url = "mirror://gnu/hello/hello-${finalAttrs.version}.tar.gz";
            #sha256 = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA=";
            #sha256 = "0000000000000000000000000000000000000000000000000000";
            hash = "sha256-+yHgdh+AyFvt1wJVZZ2UemCPa/2+OJnl62SEidm9xos=";
          };

            nativeBuildInputs = (finalAttrs.nativeBuildInputs or []) ++ [
              final.jq
          ];
        }));
      })
    ]; 
  };
in pkgs.hello
