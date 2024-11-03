#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# exporting important env variables
export PATH=$PATH:~/Scripts:~/bin
export EDITOR=nvim
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk

# Start slstatus
if ! pgrep -x "slstatus" > /dev/null; then
    slstatus &
fi

# Start picom
if ! pgrep -x "picom" > /dev/null; then
    picom &
fi

# Start sxhkd
if ! pgrep -x "sxhkd" > /dev/null; then
    sxhkd &
fi

# Start xscreensaver
if ! pgrep -x "xscreensaver" > /dev/null; then
    xscreensaver --no-splash &
fi

# Start dunst (notification manager)
if ! pgrep -x "dunst" > /dev/null; then
    dunst &
fi

# Set the background with feh
./.fehbg

# Run the touchpad fix Script
~/Scripts/touchpad_fix.sh
