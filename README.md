# Simple Quickshell Bar
*This project is still in active development.*<br /><br />
A distraction free, lightweight Taskbar for Hyprland. Only shows what you really need.<br /><br />
![Showcase](./showcase.gif)
<br />

## Features
- **Dynamic Notch**: Morphs smoothly to only show you information you actually need to see.
- **Hyprland Integration:** When switching workspaces the notch will show active, used and unused workspaces.
- **Battery**: Icon switches to yellow and red, reminding you to charge your laptop.
- **WiFi**: Shows signal strength to the current network.
<br /><br />*[Planned features](#planned-features)*

# Setup

## Dependencies
Ensure your system has the following dependencies installed and Hyprland running:

### Core Requirements
- **[Quickshell](https://quickshell.org/)**:
```bash
pacman -S quickshell
```
- **[Hyprland](https://hypr.land/)**:
```bash
pacman -S hyprland
```
- **Nerd Font**:
```bash
pacman -S ttf-jetbrains-mono-nerd
```

### Hardware Utilities
Showing connection and signal strength to the current network relies on iwd. This project currently does not support other network utilities such as NetworkManager. If you do not already use iwd, ensure to install and enable it while disabling other network managers to avoid errors.
- **Install iwd**:
```bash
pacman -S iwd
```
- **Enable it on systemd**:
```bash
systemctl enable --now iwd # and disable other network utilities
```

## Install & Run
- **Clone** the repository:
```bash
git clone https://github.com/sanin-alex/arch-quickshell
```
- **Open** the folder:
```bash
cd arch-quickshell
```
- **Start** it with the following command:
```bash
qs -p shell.qml
```
- To **automatically** run it on start up add it to `~/.config/hypr/hyprland.lua`:
```bash
hl.on("hyprland.start", function ()
	hl.exec_cmd("quickshell -p /path/to/arch-quickshell/shell.qml")
end)
```

# Planned Features
Since this project is still in active development, features will be added in the future. This list also serves to show what is not yet supported.

- **Hover**: When the mouse is hovered on the notch, it will expand and show all information at once and buttons will be clickable.
- **Media Player**: Media Player support to show currently playing media on the device.
- **Bluetooth Integration**: Show currently connected devices and an interface to manage connections.
- **WiFi Integration**: Show which network the device is currently connected to and an interface to manage connections. (Currently only shows signal strength to the current network)
- **Quick Settings**: A drop-down menu to adjust volume and screen brightness.
- **Custom Configuration**: Easily change colors and customize look and feel.
