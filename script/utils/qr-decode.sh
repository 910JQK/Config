#!/bin/sh
# ImageMagick, zbar and zenity is required

# ©lilydjwg
r="$(import png:- | zbarimg /dev/stdin)"
gdialog --msgbox "${r}"
unset r
