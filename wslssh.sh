WIN_USER = powershell.exe '$env:UserName'
cp -r /mnt/c/Users/$WIN_USER/.ssh ~
chmod 600 ~/.ssh/id_rsa
