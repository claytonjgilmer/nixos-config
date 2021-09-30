{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    # C/C++ stuff
    gcc
    clang
    gdb
    lldb
    cmake
    # Python stuff
    python39
    # Rust stuff
    rustup
  ]
}
