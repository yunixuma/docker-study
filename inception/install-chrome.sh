#/bin/bash
PATH_LOG=./`basename $0 .sh`.log

## include
. ./install-common.sh

log_echo "\033[32;1m[$(date +"%Y-%m-%d %H:%M:%S")]\t$0\033[m"

ls /root/* >> /dev/null
if [ $? -ne 0 ]; then
	SUDO="sudo"
	log_echo "\033[35mRun as regular user.\033[m"
else
	SUDO=""
	log_echo "\033[35mRun as root.\033[m"
fi

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrom-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
    | sudo tee /etc/apt/sources.list.d/google-chrome.list | tee -a $PATH_LOG
curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
    | sudo gpg --dearmor -o /usr/share/keyrings/googlechrom-keyring.gpg | tee -a $PATH_LOG
exec_cmd "$SUDO apt update"
install_cmd google-chrome-stable
