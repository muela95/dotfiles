setxkbmap -layout es -variant dvorak -option caps:backspace shift:both_capslock &
xmodmap -e "clear Lock" &

wal -R &
picom -b --experimental-backends&
#urxvtd --quiet --opendisplay --fork &
#xrdb -merge .Xresources &
emacs --daemon &
xrdb -merge ~/.Xresources &

exec qtile
