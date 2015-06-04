[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources && mpd

#Make java apps use the GTK theme
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true 
-Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel 
-Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"

# XFCE
#exec startxfce4

# Start window manager in the background. If it dies, X still lives.
#2bwm &

# Start a terminal in the foreground. If this dies, X dies.
#exec urxvt

# dwm + conky + feh + stalonetray
(sleep 1 && /usr/bin/ck-launch-session) &
# /usr/bin/stalonetray --geometry 16x16+150-586 --icon-size 16 &
sh ~/.fehbg &
(sleep 2 && /usr/bin/nm-applet) &
(conky | while read LINE; do xsetroot -name "$LINE"; done) &

exec dwm
