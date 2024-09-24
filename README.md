# Abyssal Descent
Join the [Discord](https://discord.gg/S43xbbHAe2) for more information  

> **Note:**  
> This project is still in development, read [Known Issues](KNOWN_ISSUES.md)

PR's and Issues welcome, but please read [CONTRIBUTING.md](CONTRIBUTING.md)

## Building
**Dependencies:** `make`, `curl`, `awk`, JDK 17
```bash
make all # downloads mods, builds from source, and applies overrides
EXPORT_DIR="path/to/.minecraft/" make export # copies build dir to your instance
```

> **For Windows:**  
> Additional dependencies: `dos2unix`  
> You'll need to build this in `wsl` or with `cygwin`, the build system doesnt work with pure win  
> **Note:** the `Makefile` may missbehave, try running `dos2unix Makefile` if that happens
