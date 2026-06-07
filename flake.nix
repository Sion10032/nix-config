{
  description = "Sion10032's NixOS flake";
  # How to inspect:
  # https://nixos-and-flakes.thiscute.world/zh/best-practices/debugging#%E9%80%9A%E8%BF%87-nix-repl-%E6%9F%A5%E7%9C%8B%E6%BA%90%E7%A0%81%E3%80%81%E8%B0%83%E8%AF%95%E9%85%8D%E7%BD%AE

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    homebrew = {
      url = "git+https://mirrors.ustc.edu.cn/brew.git?ref=refs/tags/5.1.14";
      flake = false;
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
      inputs.brew-src.follows = "homebrew";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Shared nix-systems input used by flake-utils, nixvim, etc.
    systems.url = "github:nix-systems/default/future-26.11";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    # niri = {
    #   url = "github:sodiboo/niri-flake";
    # };

    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.inputs.systems.follows = "systems";
    };
  };

  outputs = inputs: import ./outputs.nix inputs;
}
