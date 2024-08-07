The `config.ini` goes into `/etc/ly/`

To automatically change the splash text (remember?) / box title, I made a script and did the following steps to run the script automatically on start up:

 1) I made a `<name>.service` file in `/etc/systemd/system/` with the following content:
 ```
[Unit]
Description=Update LY Splash Text
Before=ly.service

[Service]
Type=oneshot
ExecStart=/home/krishna/Scripts/update_splash.sh

[Install]
WantedBy=multi-user.target
 ```

 2) Run the following commands then:
 ```bash
 sudo systemctl daemon-reload
 sudo systemctl enable <name>.service
 ```

 3) Incase you get an error in the second command, we can try running these commands to debug the error:
 ```bash
 sudo systemctl list-unit-files | grep <name>
 ```
 
 4) Also check if there is a syntax error in the .service file which we created with this command:
 ```bash
 sudo systemd-analyze verify path/to/file
 ```

 5) Also note that this file should be readable by root.
