#===Colors
INFOun="\e[4m"							#underline
INFObo="\e[1m"							#bold
INFb="\e[34m"							#blue
INFr="\e[31m"							#red
INFOb="\e[107m${INFb}"					#blue (+white bg)
INFObb="\e[107m${INFObo}${INFb}"		#bold blue (+white bg)
INFOr="\e[107m${INFr}"					#red (+white bg)
INFOrb="\e[107m${INFObo}${INFr}"		#bold red (+white bg)

NORM="\e[0m"
GOOD="\e[1m\e[97m\e[42m"
OLD="\e[1m\e[97m\e[45m"
CHECK="\e[1m\e[97m\e[43m"
WARN="\e[1m\e[97m\e[48;5;208m"
ERR="\e[1m\e[97m\e[41m"

#==COLOR STYLE TYPE

#echo with "good" result color
good()
{
echo -e "${GOOD}$1${NORM}"
}

#echo with "warn" result color
warn()
{
echo -e "${WARN}$1${NORM}"
}

#echo with "check" result color
check()
{
echo -e "${CHECK}$1${NORM}"
}

#echo with "old" result color
old()
{
echo -e "${OLD}$1${NORM}"
}

#echo with "err" result color
err()
{
echo -e "${ERR}$1${NORM}"
}

# echo an title format
title()
{
case $2 in
	"0")echo -e "\n${INFObb}${INFOun}$1${NORM}";;
	"1")
		x=0 	#reset lvl 3
		y=0		#reset lvl 2
		((z++))	#increase lvl 1
		echo -e "\n${INFObb}${INFOun}${z}] $1${NORM}"
	;;
	"2")
		x=0 	#reset lvl 3
		((y++))	#increase lvl 2
		echo -e "\n${INFOb}${INFOun}${z}.${y}] $1${NORM}"
	;;
	"3")
		((x++)) #increase lvl 3
		echo -e "\n${INFOb}${INFOun}${z}.${y}.${x}] $1${NORM}"
	;;
	*)echo -e "\n$1";;
esac
}
