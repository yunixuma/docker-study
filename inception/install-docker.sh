#/bin/bash
PATH_LOG=./install-docker.log
echo "[$(date +"%Y-%m-%d %H:%M:%S")]\t$0" >> $PATH_LOG

## Install sudo and clone the repository
clone_repo() {
	apt-get update
	sudo -V || {
		apt-get install -y sudo
	}
	git -V || {
		sudo apt-get install -y git
	}
	git clone https://github.com/yunixuma/docker-study.git
	cd docker-study/inception
	sh ./install-docker.sh
}

## Define functions
exec_cmd() {
	CMD=$1
	echo "> $CMD" >> $PATH_LOG
	$CMD >> $PATH_LOG 2>&1
}
install_cmd() {
    CMD="$@"
	exec_cmd "sudo apt-get install -y $CMD"
}

exec_cmd "apt-get update"
curl -V || {
	install_cmd curl
}
make -v || {
	install_cmd make
}

## Check if docker compose is already installed
docker compose version && {
	echo "docker compose command is already installed." >> $PATH_LOG
	exit 0
}

## Install docker compose
## cited from https://matsuand.github.io/docs.docker.jp.onthefly/engine/install/debian/
docker -v || {
	exec_cmd "sudo apt-get remove docker-compose docker docker-engine docker.io containerd runc"
}
install_cmd ca-certificates gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
	"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
exec_cmd "sudo apt-get update"
install_cmd docker-ce docker-ce-cli containerd.io
exec_cmd "sudo usermod -aG docker $USER"
# exec_cmd "sudo systemctl enable docker"
exec_cmd "sudo service docker start"
