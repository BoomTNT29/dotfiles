# Instructions to follow for matlab

After installing Matlab's zip folder, extract and run the installer.

After that when trying to launch matlab from the `~/matlab/bin/matlab` you'll notice a `GLX..` error.
To fix that we need to link the `libstdc++.so.6` file to `~/matlab/bin/glnxa64/` folder.

After this too when running matlab we see a blank screen, that is due to the window manager, JVM has a list of hard coded window managers that it allows rendering to, hence the issue. So to get around this use `wmname`. This is written in the `~/Scripts/matlab` script. 
