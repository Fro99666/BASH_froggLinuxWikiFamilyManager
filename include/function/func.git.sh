#updateGitFolders {mainFolder} {excludeFolder} {doSubmodule}
updateGitFolders()
{
for commonFold in ${1}*;do
	#not for common folder who is a basic wiki folder
	if [ ! "${1}${2}" = $commonFold ];then
		title "$commonFold" "3"
		cd $commonFold
		#if is a git
		if [ -d ".git" ];then 
			#clean uncommitted file/folder
			git clean -fd
			#try to pull
			if git pull &> /dev/null;then
				good "$commonFold updated" 
				if [ ! -z $3 ];then
					updateGitModule $commonFold
				fi
			else
				#if can't pull, force to remove local changes
				git fetch --all
				git reset --hard origin/master
				if git pull &> /dev/null;then
					good "$commonFold updated" 
					if [ ! -z $3 ];then
						updateGitModule $commonFold
					fi
				else
					err "error occurred while pulling $commonFold"
					warnList="${warnList}\n- cannot update $commonFold"
				fi
			fi
		else
			good "$commonFold skipped : not a git repository" 
		fi
	fi
done
}

#install or update git
#updateGit {destinationFolder} {repoUrl} {doSubModule}
updateGit()
{
exist "d" "${1}/.git"
if [ $? = 0 ];then
	check "Cloning git repository"
	git clone "${2}" "${1}"
else	
	check "Updating git repository"
	cd ${1}
	git checkout master
	git pull
	if [ ! -z $3 ];then
		updateGitModule ${1}
	fi
fi
}

#update git submodules
#updateGitModule {gitFolder}
updateGitModule()
{
cd ${1}
if git submodule update --init &> /dev/null;then
	good "$1 submodule updated" 
else
	err "error occurred while pulling $1"
	warnList="${warnList}\n- cannot update $1 submodule"
fi
}

#Ask user to choose a version selected in available version
chooseGitVersion()
{
#get all version
gitVersions=$(git tag -l | sort -V)
currVersion=$(git describe --abbrev=0 --tags)
#ask if start script
makeachoice "use master branch version : ${currVersion}"
if [ $? = 0 ];then
	#display all version
	check "This is the list of version :"
	echo ${gitVersions}
	while true; do
		read -p " [ Q ] Type the version you want to install : " ver
		#check if version exist in the git version list
		testIsInArray "$ver" "$gitVersions"
		[ $? = 0 ] && err "${ver} not found in version list" || break
	done
	#check out the selected branch
	cd ${1}
	git checkout -b REL${ver}
	good "${ver} branch has been selected"
else
	#use master branch
	cd ${1}
	git checkout master
	good "master branch has been selected"
fi
}

#Clean git project file from a folder
# cleanGitFiles {folder}
cleanGitFiles()
{
#remove file or folder from FileGitDel in $1
for gitFile in ${FileGitDel[*]};do
	if rm -R ${1}/${gitFile}  &> /dev/null;then
		good "${1}/${gitFile} removed"
	fi
done
}
