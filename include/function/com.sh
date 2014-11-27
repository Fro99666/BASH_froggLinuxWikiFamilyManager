#func used to ask user to answer yes or no, return 1 or 0
# makeachoice {forThisQuestion}
makeachoice()
{
userChoice=0
echo " "	#add a pre space to have a better display
while true; do
	read -p " [ Q ] Do you wish to $1 ?" yn
	case $yn in
		y|Y|yes|YES|Yes|O|o|oui|OUI|Oui)userChoice=1;break;;
		n|N|no|NO|No|non|NON|Non)userChoice=0;break;;
		* )warn "'$yn' isn't a correct value, Please choose yes or no";;
	esac
done
return $userChoice
}

#newaction {question} {title}
newaction()
{
#ask user to continue
makeachoice "$2"
if [ $? = 0 ];then
	warn "Script aborted by user"
	exit 1
else
	title "$1" "1"
fi
}

# trim {string}
trim()
{
echo $1 | sed -e 's/^ *//' -e 's/ *$//'
}

# check if command exist, return false if cant exec
# canExec {command}
canExec()
{
type "$1" &> /dev/null ;
}

#File/Folder exist -f / -d return false if not found
# exist {file(f)orFolder(d)} {inThePath}
exist()
{
[ -$1 $2 ] && return 1 || return 0
}

#check if is a file or folder, return f or d
# isFile {FileOrFolder}
isFile()
{
[ -f $1 ] && echo "f"
[ -d $1 ] && echo "d"
}

#string $1 end with string $2, return 1 if endwith $2
# endWith {string} {endString}
endWith()
{
[[ $1 == *$2 ]] && return 1 || return 0
}

#add / to folder string if is not existing at the end, return good format fold
# addSlashToFold {folder}
addSlashToFold()
{
[[ "$1" == */ ]] && echo "$1" || echo "${1}/"
}

#test if an URL exist, return 1 if exist 0 if not
# urlExist {url}
urlExist()
{
curl --output /dev/null --silent --head --fail "$1" && return 1 || return 0
}

#Test if str is in array return 1 if is in array
# testIsInArray {what} {inArray}
testIsInArray()
{
#replace $1 param by FOUND if has been found in $2 array
arrTmp=${2/${1}/FOUND}
#if both arrays are equals then return 0 else return 1
[ "${arrTmp[*]}" == "${2}" ] && return 0 || return 1
}