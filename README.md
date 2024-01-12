# NixOS Configuration for MacBook Pro 2019 (T2 Chip)

This repository contains my personal NixOS configuration files tailored for a MacBook Pro 2019 model with the T2 chip. It includes settings for KDE Plasma, specific hardware configurations, and a curated list of applications I use regularly.

## Features
- **KDE Plasma Desktop**: A fully configured KDE Plasma environment for a sleek and efficient user experience.
- **MacBook Pro 2019 (T2 Chip) Compatibility**: Special tweaks and settings to ensure smooth operation on MacBook Pro 2019 with the T2 chip.
- **Essential Applications**: A selection of applications that I find essential for my daily workflow, including:
  - KDE Kate text editor
  - Chromium Browser
  - Kdenlive Video Editor
  - Ksystemlog
  - Skanpage
  - VLC
  - Gimp
  - Libreoffice
  - OBS-Studio
  - Virtualbox
  - VScodium
  - Thunderbird
  - Telegram

## Installation

1- Add and update `nixos-hardware` channel:

```shell
sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
sudo nix-channel --update
```

2- Download the following files and copy them to `/etc/nixos`:
  - `pipewire_sink_conf.nix` from https://github.com/lemmyg/t2-apple-audio-dsp/tree/speakers_161
  - `pipewire_mic_conf.nix` from https://github.com/lemmyg/t2-apple-audio-dsp/tree/mic
  - `nginx.nix` (if needed) from https://github.com/TarikSudo/nginx-multidomain-nixos

3- Copy your WiFi and Bluetooth firmware to `/etc/nixos/files/firmware/brcm`, if you do not have the firmware, follow the guide on [t2linux.org](https://wiki.t2linux.org/guides/wifi-bluetooth/).

4- Rebuild your NixOS configuration to apply the changes. Please note that the `nixos-hardware` configuration will download, patch, and install a kernel. This process is expected to take between 1 to 2 hours, depending on your system and internet speed. For more information, please visit the [nixos-hardware T2 chip page](https://github.com/NixOS/nixos-hardware/tree/master/apple/t2).

## Disclaimer

Please note that the configurations provided in this repository are specifically tailored for my personal hardware and needs. They may not directly apply to your setup without modifications. Before using these configurations, ensure that they align with your system's requirements and consider the need for additional customization. Use them at your own risk, and always back up your current configurations before making any changes.
