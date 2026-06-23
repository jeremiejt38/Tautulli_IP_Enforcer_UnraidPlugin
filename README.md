# Tautulli IP Enforcer - Unraid Plugin

Unraid plugin for managing banned IPs and user stream limits for Tautulli/Plex.

## 📋 Description

This plugin allows you to dynamically manage the Tautulli IP Enforcer script settings without having to manually edit files using a text editor. **Features:**
- 🚫 Banned IP management (add/remove)
- 👥 Stream limits per user (add/edit/remove)
- 📋 Enforcement log viewer
- ⚙️ Configuration of Tautulli location and settings
- 🔧 systemd service installation and management

## ⚠️ Prerequisites

- **Unraid 6.x or 7.x**
- **Tautulli** installed (via Docker or natively)
- SSH access for certain advanced features

## 📥 Installation

### Method 1: Via the plugin (recommended)

1. Place the `tautulli-ip-enforcer.plg` file on your Unraid server (in `/boot/config/plugins/`)
2. Or use the URL for the `.plg` file hosted on GitHub:
```
https://raw.githubusercontent.com/jeremiejt38/Tautulli_IP_Enforcer_UnraidPlugin/main/tautulli-ip-enforcer.plg
```

3. Go to **Settings → Plugins** in Unraid
4. Click **Install** next to the plugin

### Method 2: Manual installation

1. Clone this repository to your server:
```bash
git clone https://github.com/jeremiejt38/Tautulli_IP_Enforcer_UnraidPlugin.git
```

2. Copy the files to the plugins folder:
```bash
cp -r Tautulli_IP_Enforcer_UnraidPlugin/* /boot/config/plugins/tautulli-ip-enforcer/
chmod +x /boot/config/plugins/tautulli-ip-enforcer/*.page
chmod +x /boot/config/plugins/tautulli-ip-enforcer/*.php
```

3. Refresh the Unraid page

## 🚀 Initial Configuration

Upon first launch, the plugin displays a setup wizard:

1. **Verify the script location** (default: `/mnt/user/appdata/tautulli/Tautulli_IP_Enforcer/`)
2. **Enter the IP address** of your Tautulli instance
3. **Enter the Tautulli port** (default: `8181`)
4. **Enter your Tautulli API key**

Click **Install** to:
- Automatically clone the script's GitHub repository
- Create the necessary configuration files
- Save your settings

## 📖 Usage

### Banned IPs Tab

Add the IP addresses to be banned. Any banned IP will have all its active Plex sessions terminated.

**Supported formats:**
- IPv4 (e.g., `192.168.1.100`)
- IPv6 (e.g., `2001:0db8:85a3:0000:0000:8a2e:0370:7334`)

### User Limits Tab

Define the maximum number of unique IPs allowed per Plex user.

**Example:**
- `Jean;1` → Jean can use only 1 unique IP
- `Marie;2` → Marie can use 2 different unique IPs
- `Pierre;5` → Pierre can use up to 5 unique IPs

### Logs Tab

View the history of enforcement actions in real-time.

### Settings Tab

Modify file locations, Tautulli connection details, and messages displayed to users.

### Service Tab

Manage the systemd service:
- ▶️ **Start**: Manually start the service
- ⏹️ **Stop**: Stop the service
- 🔄 **Restart**: Restart the service
- ⚙️ **Install Service**: Install the systemd service (perform once)

## 🔧 Systemd Service

The script runs continuously via a systemd service. To enable it at startup:

```bash
sudo systemctl enable tautulliipenforcer.service
```

## 📁 File Structure

```
/mnt/user/appdata/tautulli/Tautulli_IP_Enforcer/
├── tautulliIpEnforcer.py      # Main script
├── tautulliIpEnforcer.sh      # Loop script
├── tautulliipenforcer.service # systemd service
├── TautulliApiHandler.py      # API module
├── banned_ips.txt            # Banned IPs (managed via plugin)
├── concurrent_ip_limit.txt   # User limits (managed via plugin)
└── enforce_log.txt          # Enforcement logs
```

## 🔨 Troubleshooting

### The service won't start

1. Check the logs:
```bash
sudo systemctl status tautulliipenforcer.service
```

2. Verify that Tautulli is accessible at the configured IP address

### The plugin cannot find the files

- Check that the path in the settings is correct
- Verify that the files have been cloned from GitHub

### Permission error

Some actions (service installation) require sudo privileges. Connect via SSH:

```bash
sudo nano /etc/sudoers
# Or run the commands manually with sudo
```

## 📝 License

- Plugin: [GPL-3.0](./LICENSE)
- Original script: [GPL-3.0](https://github.com/Dosk3n/Tautulli_IP_Enforcer/blob/master/LICENSE)

## 🙏 Acknowledgments

- Original script created by [Dosk3n](https://github.com/Dosk3n/Tautulli_IP_Enforcer)
- Inspired by Unraid plugins from [Squidly271](https://github.com/Squidly271)
