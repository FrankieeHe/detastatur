work_dir="/home/wchen/work/"
branch="${1}"
mlog="midoco.log"
elog="error.log"


# prepare overview with tmux
# TMUX_SESSION="${branch}"
TMUX_SESSION="TMX_SS"
# if the session is not running, prepare it.
tmux has-session -t "${TMUX_SESSION}"
if [ ${?} -eq 1 ] ; then
	echo "Session ${TMUX_SESSION} not exists. preparing."
	
	parm_bash="bash"
	parm_mlog="tail -F /var/log/${mlog}"
	parm_elog="tail -F /var/log/${elog}"
	
	# -d says not to attach to the session yet
	nice tmux new-session -d -s "${TMUX_SESSION}"
	# -d says not to attach to the session yet
	#tmux new-window -d
	#tmux set-option -t "${TMUX_SESSION}" set -g mouse on
	tmux set -g mouse on

	#tmux set -g pane-border-fg colour235
	#tmux set -g pane-border-bg colour238
	#tmux set -g pane-active-border-fg colour236 
	#tmux set -g pane-active-border-bg colour250

	# split pane
	tmux split-window -h -t "${TMUX_SESSION}" "${parm_mlog}"
	# split pane
	tmux split-window -v -p40 -t "${TMUX_SESSION}" "${parm_elog}"
	# split pane
	tmux split-window -v -p60 -t "${TMUX_SESSION}" -c "${work_dir}${branch}/release-merge/build/" "${parm_bash}"
	# select pane
	tmux select-pane -L -t "${TMUX_SESSION}"
	# split pane
	tmux split-window -v -t "${TMUX_SESSION}" -c "${work_dir}${branch}/release-merge/jboss/bin/" "${parm_bash}"
	
fi

# now attach to the window
tmux attach-session -t ${TMUX_SESSION}
