{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.nixos.browser-policies;

  sharedPolicy = {
    DefaultSearchProviderEnabled = true;
    DefaultSearchProviderName = "Brave Search";
    DefaultSearchProviderSearchURL = "https://search.brave.com/search?q={searchTerms}";
    DefaultSearchProviderSuggestURL = "https://search.brave.com/api/suggest?q={searchTerms}";

    RestoreOnStartup = 1;

    PromptForDownloadLocation = false;

    PasswordManagerEnabled = false;
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    PaymentMethodQueryEnabled = false;

    MetricsReportingEnabled = false;
    UrlKeyedAnonymizedDataCollectionEnabled = false;
    SpellCheckServiceEnabled = false;

    DefaultNotificationsSetting = 2;
    DefaultGeolocationSetting = 2;

    BrowserSignin = 0;
  };

  bravePolicy = {
    BraveRewardsDisabled = true;
    BraveWalletDisabled = true;
    BraveVPNDisabled = true;
    BraveAIChatEnabled = false;
    BraveTalkDisabled = true;
    BraveNewsDisabled = true;
  };

  sharedPolicyFile = pkgs.writeText "browser-policy-shared.json" (builtins.toJSON sharedPolicy);
  bravePolicyFile = pkgs.writeText "browser-policy-brave.json" (builtins.toJSON bravePolicy);
in
{
  options.modules.nixos.browser-policies.enable =
    lib.mkEnableOption "managed policies for brave and chromium";

  config = lib.mkIf cfg.enable {
    environment.etc = {
      "brave/policies/managed/00-shared.json".source = sharedPolicyFile;
      "brave/policies/managed/10-brave.json".source = bravePolicyFile;
      "chromium/policies/managed/00-shared.json".source = sharedPolicyFile;
    };
  };
}
