#if backup already exist, will store them to backup folder
# autoBackUp {fileOrFolder} {destination}
autoBackUp()
{
typ=$(isFile $1)
exist $typ $1
if [ $? = 1 ];then
	#if destination exist then remove it
	exist $typ ${2}
	[ $? = 1 ] && rm -R "${2}"
	#copy to backup
	cp -r $1 $2
	#display result
	good "$1 backuped to $2"
else
	err "unable to autobackup $1 : not found"
fi
}

#check if backup folder already exist, and ask user to make a choice
#checkBackUp {backUpFolder} {DoNotStopScript}
checkBackUp()
{
#check if update already made same day
exist "d" "${1}"
if [ $? = 1 ];then
	makeachoice "override the update already made today, backup file will be overwritten"
	if [ $? = 0 ];then
		if [ -z $2 ];then
			warn "Script aborted by user"
			exit 1
		else
			echo 1 
		fi
	fi
fi
#create the backup folder if not exist
mkdir -p ${1%/*}
}

# rollBackSelection {backUpFolder}
rollBackSelection()
{
#read backup folder and list available backups
bkList=(${1}/*)
bkList=(${bkList[@]//${1}\//})

#no result found, then exit
if [ -z $bkList ];then
	err "no backup found in ${1}, script cannot continue"
	exit 1
fi

#display all backups
check "This is the list of available backup :"
echo ${bkList}
#user choose a backup to restore
while true; do
	read -p " [ Q ] Type the backup you want to restore : " bk
	#check if version exist in the git version list
	testIsInArray "$bk" "$bkList"
	[ $? = 0 ] && err "${bk} not found in version list (Ctrl+C to exit script)" || break
done

#do the restore
makeachoice "rollback $bk...current files & data will be overwritten /!\ "
if [ $? = 0 ];then
	warn "Script aborted by user"
	exit 1
fi
}
