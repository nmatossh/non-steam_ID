# non-steam_ID

# steam-shortcuts-appid

Extrae el `appid` numérico y el nombre de cada juego non-Steam (acceso directo/shortcut) configurado en Steam, parseando directamente el archivo binario `shortcuts.vdf`.

## Finalidad

Steam asigna a cada juego non-Steam un `appid` generado (CRC32 sobre el ejecutable + nombre) que también se usa como nombre de carpeta en `steamapps/compatdata/<appid>/` cuando el juego corre bajo Proton. Ese `appid` no es legible ni buscable por otros medios simples: herramientas como `strings` descartan el valor porque está almacenado en binario (4 bytes little-endian), no como texto.

Este script resuelve ese problema leyendo el `.vdf` en binario y extrayendo el valor real de `appid` junto al `AppName` correspondiente, permitiendo identificar a qué juego pertenece cada carpeta de `compatdata` (saves, prefijos de Wine, configuración de Proton, etc.).

## Uso

```bash
python3 steam_shortcuts_appid.py
```

Sin argumentos. Recorre automáticamente `~/.local/share/Steam/userdata/*/config/shortcuts.vdf` y muestra por cada shortcut encontrado:

## Requisitos

- Python 3
- Instalación nativa de Steam en Linux (no cubre Flatpak ni rutas custom de Steam Deck)

## Limitaciones

- Solo lee shortcuts non-Steam definidos en `shortcuts.vdf`; no identifica compatdata de juegos comprados en Steam.
- No detecta ni corrige entradas corruptas o formatos de VDF no estándar.
