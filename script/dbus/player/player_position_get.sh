#!/bin/sh
add_zero(){
    aa="$@";if [ "${#aa}" = "1" ];then echo '0'"$@";else echo "$@";fi
}
A=$(dbus-send --session --dest=org.mpris.audacious --type=method_call --print-reply /Player org.freedesktop.MediaPlayer.PositionGet | awk 'NF==NR {print}')
A=${A//int32 /}
TOTAL_SEC=$(echo 'scale=2;'"${A}/1000" | bc)
MIN=$(expr ${A} / 60000)
SEC=$(echo "scale=2;${TOTAL_SEC}-${MIN}*60" | bc)
MIN=$(add_zero $MIN)
SEC_INT=${SEC/.*/}; SEC_INT=$(add_zero $SEC_INT)
SEC_FLOAT=${SEC/*./}; SEC_FLOAT=$(add_zero $SEC_FLOAT)
echo "[${MIN}:${SEC_INT}.${SEC_FLOAT}]"
