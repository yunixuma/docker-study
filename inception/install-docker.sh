#/bin/bash
PATH_LOG=./`basename $0 .sh`.log

## include
. ./install-common.sh

log_echo "\033[32;1m[$(date +"%Y-%m-%d %H:%M:%S")]\t$0\033[m"

## Clone the repository
clone_repo() {
	sudo apt-get install -y git
	git clone https://github.com/yunixuma/docker-study.git
	cd docker-study/inception
	sh ./install-docker.sh
}

# sudo -V || {
# 	apt-get install -y sudo
# }
ls /root/* >> /dev/null
if [ $? -ne 0 ]; then
	SUDO="sudo"
	log_echo "\033[35mRun as regular user.\033[m"
else
	SUDO=""
	log_echo "\033[35mRun as root.\033[m"
fi

exec_cmd "$SUDO apt-get update"

git -V || {
	install_cmd git
}

exec_cmd "apt-get update"
curl -V || {
	install_cmd curl
}
make -v || {
	install_cmd make
}

log_echo "## Check if docker compose is already installed"
docker compose version && {
	log_echo "docker compose command is already installed."
	exit 0
}

log_echo "## Install docker compose"
## cited from https://matsuand.github.io/docs.docker.jp.onthefly/engine/install/debian/
docker -v || {
	exec_cmd "$SUDO apt-get remove docker-compose docker docker-engine docker.io containerd runc"
}
install_cmd ca-certificates gnupg
# install_cmd lsb-release
KEYRING=/usr/share/keyrings/docker-archive-keyring.gpg
# $SUDO install -m 0755 -d /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/debian/gpg | $SUDO gpg --dearmor -o $KEYRING
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | $SUDO gpg --dearmor -o $KEYRING 2>&1 | tee $PATH_LOG 
# echo \
# 	"deb [arch=$(dpkg --print-architecture) signed-by=$KEYRING] https://download.docker.com/linux/debian \
# 	$(lsb_release -cs) stable" | $SUDO tee /etc/apt/sources.list.d/docker.list > /dev/null
echo \
	"deb [arch="$(dpkg --print-architecture)" signed-by=$KEYRING] https://download.docker.com/linux/ubuntu \
	"$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
	$SUDO tee /etc/apt/sources.list.d/docker.list 2>&1 | tee $PATH_LOG
exec_cmd "$SUDO apt-get update"
install_cmd docker-ce docker-ce-cli containerd.io
exec_cmd "$SUDO usermod -aG docker $USER"
# exec_cmd "$SUDO systemctl enable docker"
exec_cmd "$SUDO service docker start"
