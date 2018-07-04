#!/bin/bash

scriptname=$(basename "$0")
scriptext="${scriptname##*.}"
eff=1
all=1
step=0
pause=5

showhelp () {
	echo
	echo "USAGE: $scriptname [options] target item [item...]"
	echo "OPTIONS:"
	echo "    -s <num>   Deploy step <num> (default is all steps)"
	echo "    -e         Echo (does not deploy)"
	echo "    -p <num>   Pause (seconds) between steps (default=5, 0=manual)"
	echo
	exit 1
}

while getopts "ep:s:" opt; do
	case "$opt" in
	e)	eff=0
		;;
	p)	pause=$OPTARG
		;;
	s)	step=$OPTARG
	esac
done

shift $((OPTIND-1))

#[ "$1" = "--" ] && shift

re_num='^[0-9]+$'
if ! [[ $step =~ $re_num ]] ; then
	echo "Step <num> is not a positive integer"
	showhelp
fi
if ! [[ $pause =~ $re_num ]] ; then
	echo "Pause <num> is not a positive integer"
	showhelp
fi

if [ "$#" -lt 2 ]; then
	echo "Illegal number of parameters"
    showhelp
fi

target="$1"
if ! [ -d "$target" ]; then
	echo "Target is not a folder"
	showhelp
fi

shift

echo Checking scripts...
for item in $*; do 
	if ! [ -f "$item" ]; then
		echo Not found: ${item}
		showhelp
	else
		echo Checked: ${item}
	fi
done
echo

waitorpause() {
	if [ $pause -eq 0 ]; then
		read -n1 -r -p "Press any key to continue..." key
		echo
	else
		echo Sleeping $pause seconds...
		sleep $pause
	fi
}

deploy() {
	if [ $eff -eq 1 ]; then
		if ! [[ $1 =~ $re_inet ]] ; then
			if [ ${1:0:1} == "/" ]; then
				cp "$1" "$target"
			else 
				cp "${itemdir}/$1" "$target"
			fi
		else
			cd "$target"
			curl -J -O -k -L -C - "$1"
			cd -
		fi
	fi
}

execitem() {

	item="$1"
	#echo Checking: $item

	if ! [ -f "${item}" ]; then
		echo Item \"${item}\" not found
		showhelp
	fi

	itemdir=$(dirname "$item")
	itembase=$(basename "$item")
	itemext="${itembase##*.}"

	if [ "$itemext" == "$scriptext" ]; then
		echo Executing item: $item
		source "$item"
		#If resources are not set, shows help
		if [ ${#resources[@]} -eq 0 ]; then
			echo "Script \"${item}\" does not declare resources array"
			showhelp
		fi
	else
		echo Found item: $item
		declare -a resources=("${item}")
	fi
	
	if [ $step -gt ${#resources[@]} ]; then
		echo "Step <num> is greater than available resources"
		showhelp
	fi

	if [ $step -gt 0 ]; then
		all=0
	fi

	echo

	if [ $all -eq 1 ]; then 
		step=${#resources[@]}
	fi

	re_inet='^.+:\/\/.+$'

	for i in "${resources[@]}" 
	do
		if [ $step -gt 0 ]; then
			((step--))
		fi
		if [ $all -eq 1 ]; then
			echo "$i"
			deploy "$i"
			if [ $step -gt 0 ]  && [ $eff -eq 1 ]; then
				waitorpause
			fi
		else
			if [ $step -eq 0 ]; then
				echo "$i"
				deploy "$i"
				break
			fi
		fi
	done

}

while (( "$#" )); do 
  execitem "$1"
  shift 
  if [ $# -gt 0 ]; then 
	echo
	if [ $eff -eq 1 ]; then
		waitorpause
	fi
  fi
done

exit 0

