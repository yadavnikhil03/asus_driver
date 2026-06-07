# ASUS Driver Hub

A standalone PowerShell utility for automated ASUS driver download, ASUS driver update, and silent installation on Windows. Built for ASUS TUF laptops, but adaptable to any ASUS motherboard driver setup. Handles ASUS audio driver, ASUS chipset driver, ASUS bluetooth driver, and more -- all from a single script with a dark-themed WPF GUI.

No Python. No Node.js. No package managers. Runs natively on a clean Windows install.

---

## Quick Start -- Run Directly from GitHub

Open **PowerShell** (or **Windows Terminal**) and paste this one-liner:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; git clone https://github.com/yadavnikhil03/asus_driver.git "$env:TEMP\asus_driver"; & "$env:TEMP\asus_driver\install_drivers.ps1"
```

This will:
1. Temporarily bypass execution policy for the current session.
2. Clone the repository to a temp folder.
3. Launch the ASUS driver installer GUI automatically.

> If you do not have `git` installed on a fresh Windows setup, use the manual download method described below.

### Alternative: Manual Download

1. Go to [github.com/yadavnikhil03/asus_driver](https://github.com/yadavnikhil03/asus_driver) and click **Code > Download ZIP**.
2. Extract the ZIP to any folder.
3. Right-click `install_drivers.ps1` and select **Run with PowerShell**.

---

## Included Drivers

The following ASUS driver packages are pre-configured in `drivers.json`:

| Category | Driver | Winget ID |
|---|---|---|
| Chipset | AMD Chipset Driver | `AMD.ChipsetDrivers` |
| Graphics | AMD Graphics Driver | `AMD.RadeonSoftware` |
| Graphics | NVIDIA Graphics Driver (ROG DCH) | `Nvidia.DisplayDriver` |
| Graphics | AMD Radeon Control Panel (HSA) | `AMD.RadeonSoftware` |
| Audio | Realtek Audio Driver (DTS ROG) | `Realtek.Audio` |
| Audio | Realtek Audio Driver (Only) | `Realtek.Audio` |
| Bluetooth | MediaTek Bluetooth Driver | `MediaTek.Bluetooth` |
| Touchpad | ASUS Precision TouchPad Driver | `Asus.ASUSPrecisionTouchpadDriver` |
| ASUS Utilities | ASUS Smart Display Control | `Asus.ASUSSmartDisplayControl` |
| ASUS Utilities | ASUS System Control Interface v3 | `Asus.AsusSystemControlInterface3` |
| ASUS Utilities | Armoury Crate and Aura Creator | `Asus.ArmouryCrateInstaller` |
| ASUS Utilities | Armoury Crate Control Interface | `Asus.ArmouryCrate` |
| ASUS Utilities | ASUS Refresh Rate Service | `Asus.ASUSRefreshRateService` |
| ASUS Utilities | ASUS Wireless Radio Control | `Asus.ASUSWirelessRadioControl` |

This covers the core ASUS driver stack: ASUS chipset driver, ASUS audio driver, ASUS bluetooth driver, graphics drivers, and ASUS-specific system utilities. If you need an ASUS motherboard driver or an ASUS x99a base system device driver, add its entry to `drivers.json` following the schema below.

---

## Adding or Updating Drivers

Edit `drivers.json` to add new ASUS driver entries or update existing ones. Each entry uses this schema:

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

- If `DownloadUrl` is empty, the download option will not appear for that driver.
- If `WingetId` is empty, winget installation will be skipped for that driver.
- This is the recommended approach for adding any ASUS driver download source, whether it is an ASUS motherboard driver, an ASUS x99a base system device driver, or any other hardware-specific package.

---

## Post-Reinstall Usage

After a fresh Windows reinstall or reset:

1. Run the one-liner from the Quick Start section above, **or** clone/download the repository manually.
2. If you have a local backup of your ASUS driver installers (e.g., on a USB drive), copy the `.exe` files into the same folder as `install_drivers.ps1`.
3. The script will detect local installers automatically. For any missing drivers, it will attempt ASUS driver download from the configured URLs.

If script execution is restricted on your machine:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install_drivers.ps1
```

---

## Pushing to GitHub

The `.gitignore` is pre-configured to block `.exe` files, so you can safely push this repository without uploading large proprietary binaries (which would violate licensing terms and exceed GitHub's 100MB file size limit).

```bash
git init
git add .
git commit -m "Initialize ASUS driver hub installer"
git remote add origin https://github.com/yourusername/your-repo-name.git
git branch -M main
git push -u origin main
```

Only `install_drivers.ps1`, `drivers.json`, `.gitignore`, and `README.md` will be committed. None of the `.exe` installer files are included.

---

## Keywords

asus driver, asus driver hub, asus driver download, asus driver update, asus bluetooth driver, asus motherboard driver, asus audio driver, asus chipset driver, asus x99a base system device driver

---

## Author

Developed by [@yadavnikhil03](https://github.com/yadavnikhil03)
