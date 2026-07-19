{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  udev,
}:

rustPlatform.buildRustPackage rec {
  pname = "usbeehive";
  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "abrauchli";
    repo = "usbeehive";
    rev = "v${version}";
    hash = "sha256-5aqEqt0zwzG4O+roq0p4vs59z7s2ERPE+FzyW9waegw=";
  };

  cargoLock.lockFile = "${src}/Cargo.lock";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ udev ];

  meta = {
    description = "Tells you what each USB cable / device on Linux can actually do";
    homepage = "https://github.com/abrauchli/usbeehive";
    license = lib.licenses.mit;
    mainProgram = "usbeehive";
    platforms = lib.platforms.linux;
  };
}
