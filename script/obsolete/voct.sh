#!/bin/bash

for a in $@
do
case $a in
    file=*)
	    file="$(echo $a|sed 's/.*=//;s/%sp%/ /g')"
	    ;;
    list)
	mode=list
	;;
    find=*)
	mode=find
	var="$(echo $a|sed 's/.*=//;s/,,/ /g')"
	;;
    add=*)
	mode=add
	var="$(echo $a|sed 's/.*=//')"
	;;
    del=*)
	mode=del
	var="$(echo $a|sed 's/.*=//;s/,,/ /g')"
	;;
    help)
	    cat <<EOF
单词表程序
用法：voct file= [list|help|add=|del=|find=]
 file=文件名
  文件名中空格一律用%sp%代替，文件名中不能出现%sp%
 list
  列出文件中所有项目
 help
  显示本帮助
 add=添加条目1[,,添加条目2,,添加条目3...]
 del=删除条目1[,,删除条目2,,删除条目3...]
 find=查找条目1[,,查找条目2,,查找条目3...]
 条目与条目之间以,,(半角)分隔
 删除根据行开头，例如del=abc能删除abc和abcd
 若有需要删除条目，请务必使用find先查找，然后使用要删条目的独立开头(与其他条目保证不重合)删除
 等号后不能再有等号，推荐使用"——"代替
EOF
	    exit
esac
case $mode in
    list)
	cat "$file"
	;;
    find)
	for var3 in $var
	do
	cat "$file"|grep --color=never $var3
	done
	;;
    del)
	for var0 in $var
	do
	sed -i "/^$var0/d" "$file"
	done
	;;
    add)
	touch $file
	have=1
	[ $have = 1 ] && var2="$(echo $var|sed 's/%sp%/ /g;s/,,/#enter#/g')" && echo $var2 >> "$file" && sed -i 's/#enter#/\n/g' "$file"
esac
done
