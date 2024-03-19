{
  description = "SkyrimSE xEdit Echantment script";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    pre-commit-hooks.inputs.nixpkgs.follows = "nixpkgs";
    pandoc-bbcode_nexus = {
      url = "github:loicreynier/pandoc-bbcode_nexus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    flake-utils,
    nixpkgs,
    pre-commit-hooks,
    ...
  } @ inputs: (flake-utils.lib.eachDefaultSystem (system: let
    pkgs = import nixpkgs {inherit system;};
    inherit (inputs.pandoc-bbcode_nexus.packages.${system}) pandoc-bbcode_nexus;
  in {
    checks = {
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;

        hooks = {
          make_description = {
            enable = true;
            name = "make-description";
            entry = "${pkgs.gnumake}/bin/make description.bbcode";
            files = "description.md";
          };

          alejandra.enable = true;
          commitizen.enable = true;
          checkmake.enable = true;
          deadnix.enable = true;
          editorconfig-checker.enable = true;
          prettier.enable = true;
          statix.enable = true;
          typos.enable = true;
        };
      };
    };

    devShells.default = pkgs.mkShell {
      inherit (self.checks.${system}.pre-commit-check) shellHook;
      buildInputs = with pkgs; [
        gnumake
        zip
        pandoc-bbcode_nexus
      ];
    };
  }));
}
