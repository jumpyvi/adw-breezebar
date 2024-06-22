
## adw-breezebar

Window decorations the for KDE to make QT apps look like adwaita apps, allowing KDE to look good with adwaita apps.
This uses breeze colors and not adwaita ones. A breeze theme for GTK is recommended.

This is forked from https://github.com/vinceliuice/Lavanda-kde, vinceluice did most of the work with the Lavanda theme, I simply changed a few colors and removed the global theme (kept only the decoration theme).

## Installation (ALPHA -> will also install a useless plasma style and some colors are wrong )

```sh
./install.sh
```

## Uninstall (NYI -> Will not uninstall anything, use ``` rm -r ~/.local/share/aurora/themes/adw-breezebar-* ``` to remove )

```sh
./uninstall.sh
```

## Recommendations

- Use adwaita title bar in native adwaita apps instead of KDE one: ```bash gsettings set org.gnome.desktop.interface icon-theme Adwaita ```
- Use the Breeze gradience theme: https://gradienceteam.github.io/

## License

GNU GPL v3

## preview
This is the alpha version, colors should be more acurate in futur commits

![adw-breezebar](Screenshot_dark.png)


