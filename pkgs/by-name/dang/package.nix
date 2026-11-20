{
  lib,
  buildGoModule,
  inputs,
}:
let
  src = inputs.dang;
  date = src.lastModifiedDate;
in
buildGoModule {
  pname = "dang";
  version = "0-unstable-${lib.substring 0 4 date}-${lib.substring 4 2 date}-${lib.substring 6 2 date}";
  inherit src;

  # go-tree-sitter compiles C from include/ and src/, which `go mod vendor` drops.
  proxyVendor = true;
  vendorHash = "sha256-zZMSbV1PyYuTj5ov4g0HKPwAYApRHnGV63oiyOa+QGU=";

  subPackages = [ "cmd/dang" ];
  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Statically typed GraphQL scripting language (Dagger's native DSL)";
    homepage = "https://github.com/vito/dang";
    license = lib.licenses.asl20;
    mainProgram = "dang";
  };
}
