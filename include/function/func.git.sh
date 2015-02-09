#updateGitFolders {mainFolder} {excludeFolder}
updateGitFolders()
{
for skinFold in ${1}*;do
	#not for common folder who is a basic wiki folder
	if [ ! "${1}${2}" = $skinFold ];then
		title "$skinFold" "3"
		cd $skinFold
		git pull
	fi
done
}

#install or update git
#updateGit {destinationFolder} {repoUrl}
updateGit()
{
exist "d" "${1}"
if [ $? = 0 ];then
	check "Cloning git repo"
	git clone "${2}" "${1}"
else
	check "Updating git repo"
	cd ${1}
	git checkout master
	git pull
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
	cd ${FoldOptWikiGit}
	git checkout -b REL${ver}
	good "${ver} branch has been selected"
else
	#use master branch
	cd ${FoldOptWikiGit}
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
	rm -r "${1}/${gitFile}"
done
}
