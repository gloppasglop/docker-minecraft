#!/bin/bash


MINECRAFT_HOME=/minecraft
TMUX_SESSION=mc
#
# TODO Add options
#

start() {
  tmux new -s $TMUX_SESSION "java -Xmx1024M -jar $MINECRAFT_HOME/minecraft_server.jar"
}

stop() {
  tmux send -t $TMUX_SESSION "say SERVER SHUTTING DOWN. Saving map..." ENTER
  tmux send -t $TMUX_SESSION "save-all" ENTER
  tmux send -t $TMUX_SESSION "stop" ENTER
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
esac
