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

1. Install Cygwin (https://cygwin.com/)

2. Select, "Install from Internet," choose where to install it at, choose where you want the, "Local Package Directory," to be, select "Use System Proxy Settings," and then choose a download site (I don't think it matters which one you choose.)

3. Make this new menu wide enough for everything to fit. Next to the word "View," in the dropdown menu, change "Pending," to "Full." Search, "git," (without the comma or quotation marks) and in the dropdown menu for it change, "Skip," to, the latest version. After that, do the same thing but instead of, "git," you'll want, "make," "gawk," and, "curl." After that hit next, next, finish and you're done with this part. Be sure to make a shortcut when it asks you to, unless you're already familiar with Cygwin.

4. Go here (https://www.oracle.com/java/technologies/downloads/), select JDK 17 then select Windows, download the MSI Installer and run through the wizard. Don't worry about, "Next Steps."

5. Run the Cygwin64 Terminal shortcut. Run the following commands (you can copy paste with right click but not with ctrl+v):
`git clone https://github.com/Eclipse-Ilx/Abyssal-Descent`
`cd Abyssal-Descent`
`make all`

6. Go to the file you installed Cygwin to, then go into `\home\[YOUR USERNAME]\Abyssal Descent`. The build file is the modpack. You can drag the contents of that folder into the profile folder in a mod manager of your choice, then you're done!

</details>
