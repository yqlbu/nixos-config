{ sharedLib, ... }:

{
  imports = sharedLib.scanPaths ./.;
}
