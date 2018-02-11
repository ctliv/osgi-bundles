#!/bin/bash

base=$(basename "$0")
dir=$(dirname "$0")
eff=1
all=1
step=0
pause=5

showhelp () {
	echo
	echo "USAGE: $base [options] target script [script...]"
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

for script in $*; do 
	if ! [ -f "$script" ]; then
		echo "Script \"${script}\" does not exist"
		showhelp
	fi
done

while (( "$#" )); do 
  execscript 
  shift 
done

exit 0

execscript() {

	script="$1"

	scriptdir=$(dirname "$script")
	scriptbase=$(basename "$script")

	#Sets default (jar is in maven target folder)
	scriptname="${scriptbase%.*}"
	declare -a resources=("target/${scriptname}.jar")
	
	#Executes script
	source "$script"
	#If resources are not set, shows help
	if [ ${#resources[@]} -eq 0 ]; then
		echo "Script \"${script}\" does not declare resources array"
		showhelp
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
			if [ $eff -eq 1 ]; then
				if ! [[ $i =~ $re_inet ]] ; then
					if [ ${i:0:1} == "/" ]; then
						cp "$i" "$target"
					else 
						cp "${scriptdir}/$i" "$target"
					fi
				else
					cd "$target"
					curl -O -k -L -C - "$i"
					cd "$dir"
				fi
			fi
			if [ $step -gt 0 ]; then
				if [ $pause -eq 0 ]; then
					read -n1 -r -p "Press any key to continue..." key
					echo
				else
					echo Sleeping $pause seconds...
					sleep $pause
				fi
			fi
		else
			if [ $step -eq 0 ]; then
				echo "$i"
				if [ $eff -eq 1 ]; then
					if ! [[ $i =~ $re_inet ]] ; then
						if [ ${i:0:1} == "/" ]; then
							cp "$i" "$target"
						else 
							cp "${scriptdir}/$i" "$target"
						fi
					else
						cd "$target"
						curl -O -k -L -C - "$i"
						cd "$dir"
					fi
				fi
				break
			fi
		fi
	done

}

