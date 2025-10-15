{
  description = "Minimal language tooling for Neovim (use system Neovim)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        # Minimal dev shell with just language-specific tools
        # Use your system Neovim, this just adds LSPs/formatters/linters
        devShells.default = pkgs.mkShell {
          name = "dev-tools";

          buildInputs = with pkgs; [
            # Only include tools not in your system profile
            # Uncomment what you need per-project:

            # Go development (when working on Go projects)
            # go
            # gopls
            # delve
            # gofumpt
            # golangci-lint

            # JavaScript/TypeScript development (when working on JS/TS projects)
            # Use Bun instead of Node.js/npm/pnpm - much faster!
            # bun  # Replaces: nodejs, npm, pnpm, yarn
            # nodePackages.typescript-language-server
            # nodePackages.prettier
            # nodePackages.eslint

            # Note: Copilot still needs Node.js (installed in system profile)
          ];

          shellHook = ''
            echo "📦 Project dev tools loaded"
            echo "Using system Neovim: $(which nvim)"
          '';
        };
      }
    );
}