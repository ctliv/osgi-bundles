#!/bin/bash

scriptreal=$(realpath "$0")
scriptabs=$(dirname "$scriptreal")
scriptdir=$(dirname "$0")
scriptname=$(basename "$0")
scriptext="${scriptname##*.}"

dryrun=0
step=0
pause=5

re_num='^[0-9]+$'
re_inet='^.+:\/\/.+$'

scripts=()
bundles=()

showhelp () {
	echo
	echo "USAGE: $scriptname [options] target item [item...]"
	echo "OPTIONS:"
	echo "    -s <num>   Deploy step <num> (default is all steps)"
	echo "    -d         Dry run (does not deploy)"
	echo "    -p <num>   Pause (seconds) between steps (default=5, 0=manual)"
	echo
	exit 1
}

while getopts "dp:s:" opt; do
	case "$opt" in
	d)	dryrun=1
		;;
	p)	pause=$OPTARG
		;;
	s)	step=$OPTARG
	esac
done

shift $((OPTIND-1))

#[ "$1" = "--" ] && shift

if ! [[ "$step" =~ $re_num ]] ; then
	echo "Step <num> is not a positive integer"
	showhelp
fi
if ! [[ "$pause" =~ $re_num ]] ; then
	echo "Pause <num> is not a positive integer"
	showhelp
fi

if [ $# -lt 2 ]; then
	echo "Illegal number of parameters"
    showhelp
fi

target="$1"
if ! [ -d "$target" ]; then
	echo "Target is not a folder"
	showhelp
fi

shift

#https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

loadBundles() {
	local item="$1"
	local sourcepath="$2"
	
	#If Inet, add to bundles
	if [[ "$item" =~ $re_inet ]] ; then
		echo Found: $item
		bundles+=("$item")
		return 0
	fi 
	
	#Tokenize item
	#echo Full: $item
	tokens=( $item )
	params=${item:${#tokens[0]}}
	item=${tokens[0]}
	#echo Item: $item
	#echo Params: $params
	
	#Path must be absolute
#	echo Sourcepath is: $sourcepath
	if ! [ "${item:0:1}" == "/" ]; then
		if [ "${sourcepath}" == "" ]; then
			#Default value
			sourcepath="."
		fi
		if [ "${sourcepath:0:1}" == "/" ]; then
			item="${sourcepath}/${item}"
		else
			item="${scriptabs}/${sourcepath}/${item}"
		fi
		item=$(realpath "${item}")
		if [ "$item" == "" ]; then
			exit 1
		fi
	fi
	
	local itemdir=$(dirname $item)
	local itembase=$(basename $item)
	local itemext="${itembase##*.}"

	#Check for existance
	if ! [ -f "${item}" ]; then
		echo Item \"${item}\" not found
		exit 1
	fi

	#If Script, then execute (only once)
	if [ "$itemext" == "$scriptext" ]; then
		#Checks if scripts was already executed
		containsElement "$item" "${scripts[@]}"
		if [ $? -ne 0 ]; then
			#echo ....Reading: $item $params
			#source $item
			eval . $item $params
			#If resources are not set, shows help
			if [ ${#resources[@]} -eq 0 ]; then
				echo "Script \"${item}\" does not declare resources array"
				exit 1
			fi
			scripts+=("$item")
			for res in "${resources[@]}" 
			do
				loadBundles "$res" "$itemdir"
			done
		fi
	else
		#Il file, add to bundles
		echo Found: $item
		bundles+=("$item")
	fi
	
}

deploybundle() {
	if ! [[ $1 =~ $re_inet ]] ; then
		echo Copying: $1
		cp "$1" "$target"
	else
		echo Downloading: $1
		cd "$target"
		curl -J -O -k -L -C - "$1"
		cd -
	fi
}

waitorpause() {
	if [ $pause -eq 0 ]; then
		echo
		read -n1 -r -p "Press any key to continue..." key
		echo
		echo
	else
		if [ $pause -gt 0 ]; then
			echo
			echo Sleeping $pause seconds...
			sleep $pause
		fi
	fi
}

echo
echo Finding bundles...
echo
while (( "$#" )); do 
  loadBundles "$1"
  shift 
done

if [ ${#bundles[@]} -eq 0 ]; then
	echo No bundles detected...
	exit 0
fi

echo
echo Deploying bundles...
echo
deployed=0
if [ $step -gt 0 ]; then
	if [ $step -gt ${#bundles[@]} ]; then
		echo "Step <num> is greater than available bundles (${#bundles[@]})"
		showhelp
	else
		((step--))
		deploybundle ${bundles[$step]}
	fi
else
	for bundle in "${bundles[@]}"; do 
		if [ $dryrun -eq 0 ] && [ $deployed -gt 0 ]; then
			waitorpause
		fi
		if [ $dryrun -eq 0 ]; then
			deploybundle $bundle
			((deployed++))
		fi
	done
fi

echo
echo Deployed $deployed bundles

exit 0

