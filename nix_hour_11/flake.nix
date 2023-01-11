{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    package = import ./default.nix {inherit pkgs;};
  in {
    packages.x86_64-linux.default = package;
    devShells.x86_64-linux.default = package.shell;
    formatter.x86_64-linux = pkgs.alejandra;
  };
}
