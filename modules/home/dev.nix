{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.modules.home.dev;
in
{
  options.modules.home.dev.enable =
    lib.mkEnableOption "development tooling (languages, LSPs, formatters, IaC, cloud, AI CLIs)";

  config = lib.mkIf cfg.enable {
    home.packages =
      (with pkgs; [
        # Languages
        python312
        nodejs_24
        lua
        go

        # LSPs
        bash-language-server
        gopls
        lua-language-server
        nil
        pyright
        tinymist

        # General dev tools
        gh
        glab
        lazygit
        pre-commit
        treefmt
        ruff
        isort
        uv
        stylua
        tree-sitter
        postgresql_18
        trivy

        # IaC
        packer
        tenv
        terraform-docs
        terraformer
        tflint
        terraform-ls

        # Cloud
        aws-vault
        awscli2
        google-cloud-sdk
        stable.ssm-session-manager-plugin

        # AI
        gemini-cli
        codex
        ollama
      ])
      ++ (with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
        claude-code
        coderabbit-cli
      ])
      ++ [
        inputs.agent-skills.packages.${pkgs.stdenv.hostPlatform.system}.oc-context
      ];
  };
}
