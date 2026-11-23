# Hopover: move your Windows PC to a new PC

<p align="center">
  <b>Got a new Windows PC? Hopover moves everything from your old PC onto it.</b><br>
  Apps, Windows settings, files, WSL and SSH keys. PC to PC over your own network, while you keep working. Windows 10 and 11.
</p>

<p align="center"><img src="docs/welcome.png" alt="Hopover: Move to your new PC. All of it." width="560"></p>

<p align="center">
  <a href="#download"><b>Download</b></a> ·
  <a href="#how-to-move">How to move</a> ·
  <a href="https://aivory.net/hopover-docs/">Docs</a> ·
  <a href="https://github.com/aivorynet/hopover/issues">Issues</a> ·
  <a href="#buy-me-a-coffee">Buy Paul a coffee</a>
</p>

<p align="center">
  <a href="https://aivory.net/coffee/"><img src="docs/coffee-mug.svg" width="64" height="64" alt="Buy Paul a coffee"></a>
</p>

Hopover is a Windows migration tool. Use it when you get a new PC and want it to work like your old one: the same apps, the same settings, the same files. Start it on both PCs, go do something else, and sit down at a new PC that already feels like yours. It's free, one file, no account. [Auf Deutsch](https://www.ilscipio.com/apps/hopover/).

## Download

**[Download Hopover.exe](https://github.com/aivorynet/hopover/releases/latest/download/Hopover.exe)** and run it. There's nothing to install.

The exe isn't code-signed yet, so Windows shows "Windows protected your PC" the first time. Click **More info**, then **Run anyway**. The SHA-256 is in the [release notes](https://github.com/aivorynet/hopover/releases/latest) if you want to check the file.

`winget install Aivory.Hopover` is on its way. Microsoft is still reviewing the package.

## What it does

- **Your apps** come back through winget, Chocolatey and the Store. No installer left? The program moves as a folder.
- **Your dev setup** moves too - WSL, Docker volumes, PostgreSQL, env vars, PATH, SSH keys, git logins, scheduled tasks.
- **Your Windows settings** come along - the small things you only notice when they're missing. Taskbar, Start pins, wallpaper, theme, desktop layout, Explorer, sounds, night light, mouse, keyboard, languages, region, power plan, notifications, privacy, Wi-Fi, hosts file, Windows features.
- **Your app settings** arrive with all of AppData and the registry entries that go with it.
- **Your files** come over, big repos, junctions and symlinks included.
- **Your caches** too, if you want them. Gradle, npm, Playwright, IDE indexes. Each one is a tick in the list.

And the part I care about most: your old PC stays in use. Keep working during the move, then click **Catch up** to fetch what changed. If a file changed on both PCs, the new one keeps its version and the other waits for you in `C:\hopover-held`. Nothing gets thrown away.

Nervous? Switch on **Preview first** and you get a text file of everything Hopover would do. Your files go directly from PC to PC, encrypted. No cloud in between.

<p align="center"><img src="docs/what-moves.png" alt="The list of what moves" width="860"></p>

## How to move

**On your old PC:** start Hopover and click **This is the old PC**. The pairing code shows up right away, next to the button. Untick what stays behind and click **Prepare the move** whenever you like.

**On your new PC:** start Hopover, click **This is the new PC** and type the code. It waits until the old PC is ready. Click **Start the move** and go get a coffee.

**When you're ready to switch:** click **Catch up with the old PC** one last time, then **Sign in to your accounts**. Hopover opens each sign-in in turn, password managers first, and you just approve them. Windows ties those logins to the old PC, so no tool can move them. Sign out of Windows once so the settings apply, and that's it.

You can close Hopover any time. It picks up where it stopped.

**Want it faster?** Plug one LAN cable straight from PC to PC and choose **Direct cable**. No router, no setup. Thunderbolt and USB4 cables work the same way if both PCs have those ports. A plain USB-C cable can't link two PCs - that's a hardware limit, sorry.

<table>
  <tr>
    <td width="50%"><img src="docs/moving.png" alt="The move in progress"></td>
    <td width="50%"><img src="docs/test-drive.png" alt="Test drive your apps during the move"></td>
  </tr>
  <tr>
    <td align="center"><sub>Files, apps and WSL move side by side.</sub></td>
    <td align="center"><sub>Halfway through, you can take your apps for a test drive.</sub></td>
  </tr>
</table>

## Why I built this

I switch PCs every 2-3 years. And every time, setting up the new one costs me a day or two. Apps, SSH keys, WSL, env vars, that one scheduled task... and three weeks later I find out what I forgot.

I wanted it to be comfortable. That's really all there is to it. Start it on both PCs, do something else, sit down at the new one and carry on.

Turns out nothing did that for my setup. The paid tools move apps and files, but I found none that claims WSL, SSH keys or env vars. And when my new laptop arrived, I gave Microsoft's own restore a chance. My desktop looked different and my settings were gone. As expected. A PC only feels like yours when the taskbar, the keyboard and the hundred small things you tuned over the years are where you left them.

So I built it. It's young - my own move is its first big test - so keep a backup of anything you can't lose. If it breaks, tell me and I'll fix it.

<p align="center"><img src="docs/delivered.png" alt="Everything made it" width="860"></p>

## Good to know

- OneDrive, SeaDrive, Google Drive, Dropbox and other cloud folders stay out of the move. So do browser profiles. They all sync by themselves after you sign in.
- Docker images come back with your next pull.
- Epic, GOG, EA and Ubisoft games download again.
- When you're done, click **Clean up** on both PCs, or say yes when you close Hopover. That removes its working folder with your Wi-Fi passwords and tokens. Your own files stay.

## Buy me a coffee

Hopover is free. If your move worked, I'd love a coffee:

<p>
  <a href="https://aivory.net/coffee/"><img src="docs/coffee-mug.svg" width="96" height="96" alt="Buy Paul a coffee"></a><br>
  <a href="https://aivory.net/coffee/"><b>Buy Paul a coffee</b></a>
</p>

The coffee is a thank-you. It buys no license and no extra features, and it keeps me fixing Hopover. A [short review](https://github.com/aivorynet/hopover/issues/new?title=My%20move%20with%20Hopover) or a [star](https://github.com/aivorynet/hopover) helps too.

Didn't work? Then you owe me nothing. [Open a ticket](https://github.com/aivorynet/hopover/issues/new) and I'll fix it.

<p align="center"><sub>Made by <a href="https://aivory.net/">AIVory</a> · <a href="https://aivory.net/hopover/">Website</a>. Source available under the <a href="LICENSE.md">PolyForm Noncommercial License</a>. Build it yourself with <code>.\build.ps1</code>.</sub></p>
