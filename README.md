# Abyssal Descent
Run on `forge 47.3.10`

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

<details>
<summary><b>For Windows 11:</b></summary>

1. Install [WSL](https://docs.microsoft.com/en-us/windows/wsl/install)  
   **TLDR:** Open PowerShell as admin and run `wsl --install`. This will likely require a reboot.
2. Open WSL by running `wsl` in the shell, then install `make`, `curl`, `git, and `openjdk-17-jdk`
    ```bash
    sudo apt update && sudo apt upgrade && sudo apt install make curl git openjdk-17-jdk`
    ```
3. Clone the repo and `cd` into it
    ```bash
    git clone https://github.com/Eclipse-Ilx/Abyssal-Descent
    cd Abyssal-Descent
    ```
4. Follow the build instructions above.  
   Windows uses `\` for paths and `C:\` for the mountpoint, so you'll need to adjust the paths.  
   `C:\Users\user\Documents\` becomes `/mnt/c/Users/user/Documents/`

</details>

<details>
<summary><b>For Windows 10:</b></summary>

I dont actually know how; You'll likely want to use `cygwin`.  
If you have a windows 10 machine and can provide instructions, please do so.

</details>
