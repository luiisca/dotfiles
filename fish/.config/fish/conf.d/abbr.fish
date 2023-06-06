#list
abbr ls "exa -lag --header"

#pacman
abbr -a sps 'sudo pacman -S'
abbr -a spr 'sudo pacman -R'
abbr -a sprs 'sudo pacman -Rs'
abbr -a sprdd 'sudo pacman -Rdd'
abbr -a spqo 'sudo pacman -Qo'
abbr -a spsii 'sudo pacman -Sii'

#fix obvious typo's
abbr cd.. 'cd ..'
abbr pdw 'pwd'
abbr udpate 'sudo pacman -Syyu'
abbr upate 'sudo pacman -Syyu'
abbr updte 'sudo pacman -Syyu'
abbr updqte 'sudo pacman -Syyu'
abbr upqll 'paru -Syu --noconfirm'
abbr upal 'paru -Syu --noconfirm'

## Colorize the grep command output for ease of use (good for log files)##
abbr grep 'grep --color=auto'
abbr egrep 'egrep --color=auto'
abbr fgrep 'fgrep --color=auto'

#readable output
abbr df 'df -h'

#keyboard
abbr give-me-azerty-be "sudo localectl set-x11-keymap be"
abbr give-me-qwerty-us "sudo localectl set-x11-keymap us"

#setlocale
abbr setlocale "sudo localectl set-locale LANG=en_US.UTF-8"
abbr setlocales "sudo localectl set-x11-keymap be && sudo localectl set-locale LANG=en_US.UTF-8"

#pacman unlock
abbr unlock "sudo rm /var/lib/pacman/db.lck"
abbr rmpacmanlock "sudo rm /var/lib/pacman/db.lck"

#arcolinux logout unlock
abbr rmlogoutlock "sudo rm /tmp/arcologout.lock"

#which graphical card is working
abbr whichvga "/usr/local/bin/arcolinux-which-vga"

#free
abbr free "free -mt"

#continue download
abbr wget "wget -c"

#userlist
abbr userlist "cut -d: -f1 /etc/passwd | sort"

#merge new settings
abbr merge "xrdb -merge ~/.Xresources"

# Aliases for software managment
# pacman
abbr pacman "sudo pacman --color auto"
abbr update "sudo pacman -Syyu"
abbr upd "sudo pacman -Syyu"

# paru as aur helper - updates everything
abbr pksyua "paru -Syu --noconfirm"
abbr upall "paru -Syu --noconfirm"
abbr upa "paru -Syu --noconfirm"

#ps
abbr psa "ps auxf"
abbr psgrep "ps aux | grep -v grep | grep -i -e VSZ -e"

#grub update
abbr update-grub "sudo grub-mkconfig -o /boot/grub/grub.cfg"
abbr grub-update "sudo grub-mkconfig -o /boot/grub/grub.cfg"
#grub issue 08/2022
abbr install-grub-efi "sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi"

#add new fonts
abbr update-fc 'sudo fc-cache -fv'

#copy/paste all content of /etc/skel over to home folder - backup of config created - beware
#skel alias has been replaced with a script at /usr/local/bin/skel

#backup contents of /etc/skel to hidden backup folder in home/user
abbr bupskel 'cp -Rf /etc/skel ~/.skel-backup-(date +%Y.%m.%d-%H.%M.%S)'

#copy shell configs
abbr cb 'cp /etc/skel/.bashrc ~/.bashrc && echo "Copied."'
abbr cz 'cp /etc/skel/.zshrc ~/.zshrc && exec zsh'
abbr cf 'cp /etc/skel/.config/fish/config.fish ~/.config/fish/config.fish && echo "Copied."'

#switch between bash and zsh
abbr tobash "sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
abbr tozsh "sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
abbr tofish "sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

#switch between lightdm and sddm
abbr tolightdm "sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed ; sudo systemctl enable lightdm.service -f ; echo 'Lightm is active - reboot now'"
abbr tosddm "sudo pacman -S sddm --noconfirm --needed ; sudo systemctl enable sddm.service -f ; echo 'Sddm is active - reboot now'"
abbr toly "sudo pacman -S ly --noconfirm --needed ; sudo systemctl enable ly.service -f ; echo 'Ly is active - reboot now'"
abbr togdm "sudo pacman -S gdm --noconfirm --needed ; sudo systemctl enable gdm.service -f ; echo 'Gdm is active - reboot now'"
abbr tolxdm "sudo pacman -S lxdm --noconfirm --needed ; sudo systemctl enable lxdm.service -f ; echo 'Lxdm is active - reboot now'"

# kill commands
# quickly kill conkies
abbr kc 'killall conky'
# quickly kill polybar
abbr kp 'killall polybar'
# quickly kill picom
abbr kpi 'killall picom'

#hardware info --short
abbr hw "hwinfo --short"

#audio check pulseaudio or pipewire
abbr audio "pactl info | grep 'Server Name'"

#skip integrity check
abbr paruskip 'paru -S --mflags --skipinteg'
abbr yayskip 'yay -S --mflags --skipinteg'
abbr trizenskip 'trizen -S --skipinteg'

#check vulnerabilities microcode
abbr microcode 'grep . /sys/devices/system/cpu/vulnerabilities/*'

#check cpu
abbr cpu "cpuid -i | grep uarch | head -n 1"

#get fastest mirrors in your neighborhood
abbr mirror "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
abbr mirrord "sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
abbr mirrors "sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
abbr mirrora "sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
#our experimental - best option for the moment
abbr mirrorx "sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
abbr mirrorxx "sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
abbr ram 'rate-mirrors --allow-root --disable-comments arch | sudo tee /etc/pacman.d/mirrorlist'
abbr rams 'rate-mirrors --allow-root --disable-comments --protocol https arch  | sudo tee /etc/pacman.d/mirrorlist'

#mounting the folder Public for exchange between host and guest on virtualbox
abbr vbm "sudo /usr/local/bin/arcolinux-vbox-share"

#enabling vmware services
abbr start-vmware "sudo systemctl enable --now vmtoolsd.service"
abbr vmware-start "sudo systemctl enable --now vmtoolsd.service"
abbr sv "sudo systemctl enable --now vmtoolsd.service"

#shopt
#shopt -s autocd # change to named directory
#shopt -s cdspell # autocorrects cd misspellings
#shopt -s cmdhist # save multi-line commands in history as single line
#shopt -s dotglob
#shopt -s histappend # do not overwrite history
#shopt -s expand_aliases # expand aliases

#youtube download
abbr yta-aac "yt-dlp --extract-audio --audio-format aac "
abbr yta-best "yt-dlp --extract-audio --audio-format best "
abbr yta-flac "yt-dlp --extract-audio --audio-format flac "
abbr yta-mp3 "yt-dlp --extract-audio --audio-format mp3 "
abbr ytv-best "yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "

#Recent Installed Packages
abbr rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
abbr riplong "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#iso and version used to install ArcoLinux
abbr iso "cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"
abbr isoo "cat /etc/dev-rel"

#Cleanup orphaned packages
abbr cleanup 'sudo pacman -Rns (pacman -Qtdq)'

# This will generate a list of explicitly installed packages
abbr list "sudo pacman -Qqe"
# This will generate a list of explicitly installed packages without dependencies
abbr listt "sudo pacman -Qqet"
# list of AUR packages
abbr listaur "sudo pacman -Qqem"
# add > list at the end to write to a file

# install packages from list
# pacman -S --needed - < my-list-of-packages.txt

#clear
abbr clean "clear; seq 1 (tput cols) | sort -R | sparklines | lolcat"

#search content with ripgrep
abbr rg "rg --sort path"

#get the error messages from journalctl
abbr jctl "journalctl -p 3 -xb"

#nvim for important configuration files
#know what you do in these files
abbr nlxdm "sudo $EDITOR /etc/lxdm/lxdm.conf"
abbr nlightdm "sudo $EDITOR /etc/lightdm/lightdm.conf"
abbr npacman "sudo $EDITOR /etc/pacman.conf"
abbr ngrub "sudo $EDITOR /etc/default/grub"
abbr nconfgrub "sudo $EDITOR /boot/grub/grub.cfg"
abbr nmkinitcpio "sudo $EDITOR /etc/mkinitcpio.conf"
abbr nmirrorlist "sudo $EDITOR /etc/pacman.d/mirrorlist"
abbr narcomirrorlist "sudo $EDITOR /etc/pacman.d/arcolinux-mirrorlist"
abbr nsddm "sudo $EDITOR /etc/sddm.conf"
abbr nsddmk "sudo $EDITOR /etc/sddm.conf.d/kde_settings.conf"
abbr nfstab "sudo $EDITOR /etc/fstab"
abbr nnsswitch "sudo $EDITOR /etc/nsswitch.conf"
abbr nsamba "sudo $EDITOR /etc/samba/smb.conf"
abbr ngnupgconf "sudo $EDITOR /etc/pacman.d/gnupg/gpg.conf"
abbr nhosts "sudo $EDITOR /etc/hosts"
abbr nhostname "sudo $EDITOR /etc/hostname"
abbr nresolv "sudo $EDITOR /etc/resolv.conf"
abbr nb "$EDITOR ~/.bashrc"
abbr nz "$EDITOR ~/.zshrc"
abbr nf "$EDITOR ~/.config/fish/config.fish"
abbr nneofetch "$EDITOR ~/.config/neofetch/config.conf"
abbr nplymouth "sudo $EDITOR /etc/plymouth/plymouthd.conf"

#reading logs with bat
abbr lcalamares "bat /var/log/Calamares.log"
abbr lpacman "bat /var/log/pacman.log"
abbr lxorg "bat /var/log/Xorg.0.log"
abbr lxorgo "bat /var/log/Xorg.0.log.old"

#gpg
#verify signature for isos
abbr gpg-check "gpg2 --keyserver-options auto-key-retrieve --verify"
abbr fix-gpg-check "gpg2 --keyserver-options auto-key-retrieve --verify"
#receive the key of a developer
abbr gpg-retrieve "gpg2 --keyserver-options auto-key-retrieve --receive-keys"
abbr fix-gpg-retrieve "gpg2 --keyserver-options auto-key-retrieve --receive-keys"
abbr fix-keyserver "[ -d ~/.gnupg ] || mkdir ~/.gnupg ; cp /etc/pacman.d/gnupg/gpg.conf ~/.gnupg/ ; echo 'done'"

#fixes
abbr fix-permissions "sudo chown -R $USER:$USER ~/.config ~/.local"
abbr keyfix "/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
abbr key-fix "/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
abbr keys-fix "/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
abbr fixkey "/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
abbr fixkeys "/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
abbr fix-key "/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
abbr fix-keys "/usr/local/bin/arcolinux-fix-pacman-databases-and-keys"
#fix-sddm-config is no longer an alias but an application - part of ATT
#abbr fix-sddm-config "/usr/local/bin/arcolinux-fix-sddm-config"
abbr fix-pacman-conf "/usr/local/bin/arcolinux-fix-pacman-conf"
abbr fix-pacman-keyserver "/usr/local/bin/arcolinux-fix-pacman-gpg-conf"
abbr fix-grub "/usr/local/bin/arcolinux-fix-grub"
abbr fixgrub "/usr/local/bin/arcolinux-fix-grub"

#maintenance
abbr big "expac -H M '%m\t%n' | sort -h | nl"
abbr downgrada "sudo downgrade --ala-url https://ant.seedhost.eu/arcolinux/"

#hblock (stop tracking with hblock)
#use unhblock to stop using hblock
abbr unhblock "hblock -S none -D none"

#systeminfo
abbr probe "sudo -E hw-probe -all -upload"
abbr sysfailed "systemctl list-units --failed"

#shutdown or reboot
abbr ssn "sudo shutdown now"
abbr sr "reboot"

#update betterlockscreen images
abbr bls "betterlockscreen -u /usr/share/backgrounds/arcolinux/"

#give the list of all installed desktops - xsessions desktops
abbr xd "ls /usr/share/xsessions"
abbr xdw "ls /usr/share/wayland-sessions"

#wayland aliases
abbr wsimplescreen "wf-recorder -a"
abbr wsimplescreenrecorder "wf-recorder -a -c h264_vaapi -C aac -d /dev/dri/renderD128 --file=recording.mp4"

#btrfs aliases
abbr btrfsfs "sudo btrfs filesystem df /"
abbr btrfsli "sudo btrfs su li / -t"

#snapper aliases
abbr snapcroot "sudo snapper -c root create-config /"
abbr snapchome "sudo snapper -c home create-config /home"
abbr snapli "sudo snapper list"
abbr snapcr "sudo snapper -c root create"
abbr snapch "sudo snapper -c home create"

#Leftwm aliases
abbr lti "leftwm-theme install"
abbr ltu "leftwm-theme uninstall"
abbr lta "leftwm-theme apply"
abbr ltupd "leftwm-theme update"
abbr ltupg "leftwm-theme upgrade"

#arcolinux applications
#att is a symbolic link now
#alias att="archlinux-tweak-tool"
abbr adt "arcolinux-desktop-trasher"
abbr abl "arcolinux-betterlockscreen"
abbr agm "arcolinux-get-mirrors"
abbr amr "arcolinux-mirrorlist-rank-info"
abbr aom "arcolinux-osbeck-as-mirror"
abbr ars "arcolinux-reflector-simple"
abbr atm "arcolinux-tellme"
abbr avs "arcolinux-vbox-share"
abbr awa "arcolinux-welcome-app"

#git
abbr rmgitcache "rm -r ~/.cache/git"
abbr grh "git reset --hard"
abbr gs "git status"
abbr ga "git add ."
abbr gc "git commit -m"
abbr gl "git log"
abbr gp "git push origin main"
abbr gcb "git checkout -b"

#pamac
abbr pamac-unlock "sudo rm /var/tmp/pamac/dbs/db.lock"

#moving your personal files and folders from /personal to ~
abbr personal 'cp -Rf /personal/* ~'

#screenshot
abbr ss scrot -d 5 -c
