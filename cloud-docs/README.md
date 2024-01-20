# RClone - Setup Google Drive files sync

## Install and configure rclone

```bash
sudo -v ; curl https://rclone.org/install.sh | sudo bash && \
rclone config
```

Google will prompt to authenticate and authorize this CLI service.
Just follow this procedure:
```
No remotes found, make a new one?
n) New remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
n/r/c/s/q> n
name> gdrive
Type of storage to configure.
Choose a number from below, or type in your own value
[snip]
XX / Google Drive
   \ "drive"
[snip]
Storage> drive
Google Application Client Id - leave blank normally.
client_id>
Google Application Client Secret - leave blank normally.
client_secret>
Scope that rclone should use when requesting access from drive.
Choose a number from below, or type in your own value
 1 / Full access all files, excluding Application Data Folder.
   \ "drive"
 2 / Read-only access to file metadata and file contents.
   \ "drive.readonly"
   / Access to files created by rclone only.
 3 | These are visible in the drive website.
   | File authorization is revoked when the user deauthorizes the app.
   \ "drive.file"
   / Allows read and write access to the Application Data folder.
 4 | This is not visible in the drive website.
   \ "drive.appfolder"
   / Allows read-only access to file metadata but
 5 | does not allow any access to read or download file content.
   \ "drive.metadata.readonly"
scope> 1
Service Account Credentials JSON file path - needed only if you want use SA instead of interactive login.
service_account_file>
Remote config
Use web browser to automatically authenticate rclone with remote?
 * Say Y if the machine running rclone has a web browser you can use
 * Say N if running rclone on a (remote) machine without web browser access
If not sure try Y. If Y failed, try N.
y) Yes
n) No
y/n> y
If your browser doesn't open automatically go to the following link: http://127.0.0.1:53682/auth
Log in and authorize rclone for access
Waiting for code...
Got code
Configure this as a Shared Drive (Team Drive)?
y) Yes
n) No
y/n> n
--------------------
[gdrive]
client_id = 
client_secret = 
scope = drive
root_folder_id = 
service_account_file =
token = {"access_token":"XXX","token_type":"Bearer","refresh_token":"XXX","expiry":"2014-03-16T13:57:58.955387075Z"}
--------------------
y) Yes this is OK
e) Edit this remote
d) Delete this remote
y/e/d> y
```

## List and manipulate files in the cloud
```bash
# List all files and details
rclone ls gdrive:

# List just the files (faster)
rclone lsd gdrive:

# To copy a local directory to a drive directory called backup
rclone copy /home/source remote:backup
```

## Mount Google Drive on a local folder
```bash
mkdir ~/Cloud && \
rclone mount --daemon --vfs-cache-mode full gdrive:/ ~/Cloud/
```

Now we can navigate and edit files in the ~/Cloud folder and rclone will keep everyting in sync.
```bash
# Just a simple test to check, create the file
# and see on Google Drive Web or via GNOME if the file was synced properly...
cd ~/Cloud && tree
vim ~/Cloud/Shared/hello-world.txt
```

It's useful to create aliases for that, like:
```bash
alias cc="cd ~/Cloud && ls -l"
alias ccs="cd ~/Cloud/Shared && ls -l"
```
