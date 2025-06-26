# Тема Midnight Commander — `kit256.ini`

Это тема `kit256.ini` для [Midnight Commander](https://midnight-commander.org/),  поддерживающая 256 цветов терминала.  

## 💾 Установка

1. Copy `kit256.ini` в директорию тем Midnight Commander:

```bash
   cp kit256.ini ~/.local/share/mc/skins/
```
или глобально:
```bash
   sudo cp kit256.ini /usr/share/mc/skins/
```

## Activating
```# F9 > Options > Appearance```
 Or
 ```bash 
 sed -i 's|\(^skin=\).*$|\kit256|' ~/.config/mc/ini
 ```
![kit256 Dark theme for mc](https://raw.githubusercontent.com/kit400/mc-themes/refs/heads/main/docs/screenshots/kit256-screenshot.png)
