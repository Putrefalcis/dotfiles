[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources && mpd

#Make java apps use the GTK theme & dwm compliant (respectively)
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true 
-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel 
-Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export AWT_TOOLKIT=MToolkit

# XFCE
#exec startxfce4

# Start window manager in the background. If it dies, X still lives.
#2bwm &

# Start a terminal in the foreground. If this dies, X dies.
#exec urxvt

# dwm + conky + feh + d-bus + java fix + screensaver

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

xscreensaver -no-splash &

#/usr/bin/stalonetray --geometry 16x16+150-586 --icon-size 16 &

sh ~/.fehbg &

(sleep 2 && /usr/bin/nm-applet) &
(conky | while read LINE; do xsetroot -name "$LINE"; done) &

wmname LG3D &
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session dwm
