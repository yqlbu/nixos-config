{ pkgs, ... }:

# Reference:
# https://wiki.archlinux.org/title/chromium
# https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
# NOTES:
# For fcitx5, we also need to disable "fractional scale under Wayland" to force it to run on Wayland natively.
{
  home.packages = with pkgs; [
    (chromium.override {
      commandLineArgs = [
        # Force GPU accleration
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"

        # Force to run on Wayland
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
        "--enable-wayland-ime"

        # Enable additional features
        "--enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,Vulkan,WebRTCPipeWireCapturer,WaylandWindowDecorations"
      ];
    })
  ];
}
