#!/usr/bin/env zsh

typeset -A window_config
typeset -A pane_config

window_config["count"]=2
window_config[1,"name"]="apps"
window_config[2,"name"]="services"

window_config[1,"panes"]=3
window_config[2,"panes"]=5

pane_config[1,1,"name"]="app1"
pane_config[1,2,"name"]="app2"
pane_config[1,3,"name"]="app3"
pane_config[2,1,"name"]="service1"
pane_config[2,2,"name"]="service2"
pane_config[2,3,"name"]="service3"
pane_config[2,4,"name"]="service4"
pane_config[2,5,"name"]="service5"

pane_config[1,1,"cmd"]="sh"
pane_config[1,2,"cmd"]="sh"
pane_config[1,3,"cmd"]="sh"
pane_config[2,1,"cmd"]="sh"
pane_config[2,2,"cmd"]="sh"
pane_config[2,3,"cmd"]="sh"
pane_config[2,4,"cmd"]="sh"
pane_config[2,5,"cmd"]="sh"

session_name="tmux session"
tmux new-session -d -s $session_name -x 2000 -y 2000

for i in {2..$window_config["count"]}
do
  tmux new-window -t $session_name:$i
done

pane_label_keys="'\033]2;%s\033\\'"
for i in {1..$window_config["count"]}
do
  tmux select-window -t $session:$i
  tmux rename-window -t $session_name:$i $window_config[$i,"name"]
  tmux setw pane-border-status bottom

  pane_count=$window_config[$i,"panes"]
  for j in {2..$pane_count}
  do
    tmux splitw
  done

  for j in {1..$pane_count}
  do
    tmux send-keys -t`echo $j` "printf $pane_label_keys $pane_config[$i,$j,\"name\"]" C-m
    tmux send-keys -t`echo $j` "$pane_config[$i,$j,\"cmd\"]" C-m
  done
  tmux select-layout tiled
  tmux select-pane -t "1"
done

tmux select-window -t $session_name:1
tmux attach -t $session_name
