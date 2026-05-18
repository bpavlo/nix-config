{ pkgs, ... }:

{
  programs.brave = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "ammjkodgmmoknidbanneddgankgfejfh"; }
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
      { id = "fadndhdgpmmaapbmfcknlfgcflmmmieb"; }
      { id = "mpiodijhokgodhhofbcjdecpffjipkle"; }
      { id = "clngdbkpkpeebahjckkjfobafhncgmne"; }
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
      { id = "jinjaccalgkegednnccohejagnlnfdag"; }
    ];
    commandLineArgs = [ ];
  };
}
