# JavaScriptCore Version Checker

A bash script to identify JavaScriptCore versions used by running applications on macOS.

## Usage

Make sure the script is executable:
```bash
chmod +x get_jsc_version.sh
```

Check all apps:
```bash
./get_jsc_version.sh
```

Check specific app, e.g. Safari:
```bash
./get_jsc_version.sh safari
```

## Requirements

- macOS
- `sample` command

## Note

May require `sudo` for process sampling.

[MIT License](LICENSE)
