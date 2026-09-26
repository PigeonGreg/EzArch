# EzArch Linux
EzArch is an Arch based Linux distribution that targets lightweight and user-friendliness. Distro uses KDE Plasma as desktop environment and has pretty good custom theme with custom wallpaper.

# Live user!
EzArch has a live user with install option inside! That means you can try distro before installing it and after use Calamares graphical installer

![Live User](readmestuff/liveuser.png)

# Installer

Graphical installer includes some packages that you might want to be installed in your system:

1.Office package that includes Libre Office(Microsoft office but better and for linux)

2.NVIDIA drivers

3.Gaming packages(Steam, Lutris(mostly for pirated or non-steam games), ProtonPlus(good manager of gaming compability tools), Wine and Bottles(both are kind of windows emulation for games, no it doesn't really lead to performance loss)

4.Some basic drivers that are selected for installation by default

5.Messengers(Discord and Telegram)

6.Emulation(Virtualbox for virtual machines and Waydroid for android emulation)

7.Development includes some code redactors and  IDEs(Code(debloated VS code), Zed(text redactor), Intellij idea, NeoVim(console text redactor)

8.Art & Design(Blender, Krita, GIMP and Inkscape)

9.Larp(basically just some cool terminal things, they serve no practical purpose, but looks cool)

# Getting EzArch

You can grab pre-built ISO file in Releases or if you have Arch or Arch-based system you can build ISO yourself:

First of all you need archiso:

```bash
sudo pacman -S archiso
```
After getting archiso you got to copy sources, go to copied directory and run special build script:

```bash
git clone https://github.com/PigeonGreg/EzArch.git
cd EzArch/
./build.sh
```
After that build process will start and you will get ISO file in ~/EzArch/out

Then simply burn ISO on usb drive(using Rufus for example) or use Ventoy and you are good to go!
