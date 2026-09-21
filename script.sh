python3 -c "
import struct, glob, os
pattern = os.path.expanduser('~/.local/share/Steam/userdata/*/config/shortcuts.vdf')
for path in glob.glob(pattern):
    with open(path, 'rb') as f:
        data = f.read()
    i = 0
    while True:
        idx = data.find(b'appid\x00', i)
        if idx == -1:
            break
        val_off = idx + len(b'appid\x00')
        appid = struct.unpack('<I', data[val_off:val_off+4])[0]
        name_idx = data.find(b'AppName\x00', val_off)
        name_end = data.find(b'\x00', name_idx+8)
        name = data[name_idx+8:name_end].decode('utf-8', errors='replace')
        print(appid, '->', name)
        i = val_off+4
"
