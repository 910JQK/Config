#!/bin/sh
#https://bbs.archlinux.org/viewtopic.php?id=114632

for a in "$@"
do

case "${a}" in
APP=*)
APP="${a//APP=/}"
;;
ICON=*)
APP="${a//ICON=/}"
;;
TITLE=*)
APP="${a//TITLE=/}"
;;
*)
BODY="${BODY} ${a}"
esac

done

BODY="${BODY/ /}"

dbus-send --type=method_call --dest='org.freedesktop.Notifications' \
/org/freedesktop/Notifications org.freedesktop.Notifications.Notify \
string:"${APP}" \
uint32:1 \
string:"${ICON}" \
string:"${TITLE}" \
string:"${BODY}" \
array:string:'' \
dict:string:string:'',''

