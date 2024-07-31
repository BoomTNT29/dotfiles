# Installation Guide

Firstly, clone dwm, dmenu and slstatus directly from the official suckless repositories.

Then, `cd <directory>` and `sudo make clean install` for each of them.

After this copy the patches folder from here and apply the patches, note some `hunks` might fail, in that case look at the `.rej` file and apply the diffs present in them.

After applying all the patches you can delete the config files and copy the *better* ones.

To applly a patch type: `patch -i /path/to/patch`
