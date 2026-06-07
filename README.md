# ASUS TUF Laptop Driver Installer

This repository contains a native PowerShell script with a modern, dark-themed WPF Graphical User Interface (GUI) to automate driver installations after a fresh Windows reinstall or reset.

It runs with **zero dependencies** on a clean Windows install—no Python, Node.js, or package managers required.

---

## Features

- **WPF Dark Mode GUI:** Designed with a clean ASUS TUF theme.
- **Self-Elevating:** Automatically requests Administrator privileges (required for installing drivers).
- **Multiple Strategies:**
  - **Local Mode (Offline):** Checks for installer files in the local directory and runs them.
  - **Winget Mode:** Attempts to install from Windows Package Manager (`winget`) when available.
  - **Download Mode (Online):** Downloads missing drivers directly from official manufacturer servers (ASUS CDN) to a temp folder and runs them.
- **Flexible Execution:**
  - **Automated (Silent):** Installs drivers in the background in sequence using silent switches (no prompt clicking needed).
  - **Interactive (Manual):** Launches installers one by one in the foreground, waiting for you to complete each wizard.
- **Log System:** Outputs details in real-time in the UI console and writes to `install_log.txt`.

---

## File Structure

- `install_drivers.ps1`: The main installer script.
- `drivers.json`: Config database mapping the installer files, winget IDs, categories, silent flags, and download URLs.
- `.gitignore`: Configured to exclude `.exe`, `.zip`, `.rar`, `.7z`, and `.log` files to prevent committing proprietary installer binaries.
- `README.md`: This file.

---

## Instructions: Pushing to GitHub (Safe from Copyrights)

The `.gitignore` file is pre-configured to block `.exe` files, so you can safely initialize, commit, and push this repository to GitHub without uploading large proprietary binaries (which violates licensing and exceeds GitHub's 100MB file size limit).

### 1. Initialize Git in the `drivers` folder:
Open a command prompt or terminal inside this directory and run:
```bash
git init
```

### 2. Add files and make your first commit:
```bash
git add .
git commit -m "Initialize ASUS TUF driver installer script"
```
*(Notice that `git status` will show only `install_drivers.ps1`, `drivers.json`, `.gitignore`, and `README.md` are staged, and none of the heavy `.exe` installer files are included).*

### 3. Link to your GitHub Repository and Push:
Create a new repository on GitHub (public or private), then run:
```bash
git remote add origin https://github.com/yourusername/your-repo-name.git
git branch -M main
git push -u origin main
```

---

## How to Run It (Post-Windows Reinstall)

1. Clone or download your repository from GitHub onto your laptop.
2. If you have a local backup of your drivers (e.g. on a USB drive), copy the `.exe` driver installers directly into this folder next to `install_drivers.ps1`.
3. Right-click `install_drivers.ps1` and select **Run with PowerShell**.
4. If script execution is restricted on your fresh Windows install:
   - Open PowerShell as Administrator.
   - Run the following command to temporarily bypass execution policy:
     ```powershell
     Set-ExecutionPolicy Bypass -Scope Process -Force
     ```
   - Run the script:
     ```powershell
     .\install_drivers.ps1
     ```

---

## Modifying the Driver Database

If you update a driver version or want to add/remove drivers, simply edit `drivers.json`.
Each entry matches this schema:
```json
{
  "FileName": "InstallerFileName.exe",
  "FriendlyName": "Display Name in GUI",
  "WingetId": "Winget.Package.Id",
  "DownloadUrl": "https://official-download-link.com/file.exe",
  "SilentArgs": "/silent-switches",
  "Category": "Graphics / Audio / Touchpad / etc."
}
```
*Note: If the `DownloadUrl` is empty, the download button will not be visible for that item. If a `WingetId` is empty, winget installation will be skipped for that item.*
