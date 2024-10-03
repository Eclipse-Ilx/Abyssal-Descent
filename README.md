# Abyssal Descent
Run on `forge 47.3.10`

Join the [Discord](https://discord.gg/S43xbbHAe2) for more information  

> **Note:**  
> This project is still in development, read [Known Issues](KNOWN_ISSUES.md)

PR's and Issues welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md)

## Building
**Dependencies:** `make`, `curl`, `awk`, JDK 17
```bash
make all # downloads mods, builds from source, and applies overrides
EXPORT_DIR="path/to/.minecraft/" make export # copies build dir to your instance
```

> **Note:**  
> When rebuilding run the following to grab the newest changes and delete the old build.
> ```bash
> git fetch && git reset --hard origin/master && make clean
> ```

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

> **Note:**  
> Windows uses `\r\n` as line separators. If you've cloned the repo outside of WSL, you'll need to remove the `\r`.
> ```bash
> find . -type f -name Makefile -exec sed -i 's/\r//' {} \;
> ```

</details>

<details>
<summary><b>For Windows 10:</b></summary>

1. Install [Cygwin](https://cygwin.com/)
2. Select `Install from Internet`, choosing the install location.
   Pick where you want the `Local Package Direcotry` to be,
   then select `Use System Proxy Settings` and choose a download site.
   (I don't think it matters which one you choose.)
3. Change `Pending` to `Full` and search for `git`, `make`, `gawk`, and `curl`.
   For each package change `Skip` to the latest version.
   Hit next, next, then finish.
   Be sure to make a shortcut when it asks you to, unless you're already familiar with Cygwin.
4. Download the MSI Installer for the [JDK 17](https://www.oracle.com/java/technologies/downloads/) and skip through the wizard.
5. Open `Cygwin64 Terminal`, then run the following commands (Right click to copy paste).
   ```bash
   git clone https://github.com/Eclipse-Ilx/Abyssal-Descent
   cd Abyssal-Descent
   make all
   ```
   This will build the pack, which will now be in the `build` directory.
6. Move the contents of the pack to the Launcher of your choice. 
   This can either be done through `EXPORT_DIR="path/to/dir" make export` or manually through your file manager.

</details>
