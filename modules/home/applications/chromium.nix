{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    extensions = [
      { id = "ammjkodgmmoknidbanneddgankgfejfh"; }
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
      { id = "fadndhdgpmmaapbmfcknlfgcflmmmieb"; }
      { id = "mpiodijhokgodhhofbcjdecpffjipkle"; }
      { id = "clngdbkpkpeebahjckkjfobafhncgmne"; }
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
      { id = "jinjaccalgkegednnccohejagnlnfdag"; }
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; }
    ];
    commandLineArgs = [ "--enable-features=VerticalTabs" ];
  };
}
