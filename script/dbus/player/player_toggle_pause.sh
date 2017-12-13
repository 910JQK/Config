#!/bin/sh
dbus-send --session --dest=org.mpris.audacious --type=method_call --print-reply /Player org.freedesktop.MediaPlayer.Pause

