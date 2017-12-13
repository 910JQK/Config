#!/bin/bash

ADDR="192.168.1.";
for i in {100..255}; do
	I="${ADDR}${i}";
	ping -c 2 "${I}" &> /dev/null \
		&& echo -e "${I} \e[32mOn-line\e[0m" \
		|| echo -e "${I} \e[31mOff-line\e[0m";
done
