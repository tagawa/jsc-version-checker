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

### Example output (all apps):

```                                                                                                                               
DuckDuckGo: 19618.3.11.11.5
Messages: 19618.3.11.11.5
Notes: 19618.3.11.11.5
Preview: 19618.3.11.11.5
Safari: 19619.2.8.111.7
Terminal: 19618.3.11.11.5
TextMate: 19618.3.11.11.5
Vivaldi: 19618.3.11.11.5
WeatherWidget: 19618.3.11.11.5
```

## Requirements

- macOS
- `sample` command

## Notes

- May require `sudo` for process sampling.
- Thanks to a helpful friend for the inspiration. :-)

[MIT License](LICENSE)
