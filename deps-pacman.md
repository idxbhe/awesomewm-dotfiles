
main packages:
```
git awesomewm thunar geany firefox mpv rofi pamixer obsidian xclip lightdm zsh viewnior bluez-utils brightnessctl networkmanager
```

audio to work:
```
pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber pavucontrol alsa-firmware sof-firmware alsa-utils
```

zsh to work properly:
```
fzf eza bat direnv paru colorscript
``
another step required to make audio work:
```
systemctl --user enable --now pipewire.service pipewire-pulse.service wireplumber.service
```


for thunar thumbnail to work:

```
gdk-pixbuf2 libgsf libwmf poppler-glib libwebp tumbler ffmpegthumbnailer
```
