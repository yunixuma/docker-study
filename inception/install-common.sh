## Define functions
log_echo() {
	echo -e "$@" | tee -a $PATH_LOG
}

exec_cmd() {
	CMD=$1
	log_echo "\033[36m> \033[1m$CMD\033[m"
	$CMD 2>&1 | tee -a $PATH_LOG
	# $CMD > >(tee -a $PATH_LOG >&1 ) 2> >(tee -a $PATH_LOG >&2)
}

install_cmd() {
    CMD="$@"
	exec_cmd "$SUDO apt-get install -y $CMD"
}
