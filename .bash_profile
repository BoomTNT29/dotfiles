#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PATH=$PATH:~/Scripts
export EDITOR=nvim

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

# Set the background with feh
./.fehbg

# Run the touchpad fix Script
~/Scripts/touchpad_fix.sh
