#Start whole add-on script
newaction "Updating all add-ons (backup & git update & files update)" "Updating all add-ons"

#prepare backup web add-on folder
mkdir -p $addonBkFolder

# for each add-on in add-on list declaration
for addon in ${addonList[@]};do

	#get add-on full info
	addonTab=(${addon//|@_@|/ })
	#get folder name from full path
	adName=${addonTab[0]##*/}
	#Create the folder if not exist
	mkdir -p ${addonTab[0]}
	
	#--do new user action
	title "Doing ${adName} backup/Git update/Files update/Restore configuration" "2"
	
	#====[ STEP ONE BACKUP ]====#
	#--BackUp Add-on file
	title "backup ${addonTab[0]} files" "3"
	#check if backup already exist & if user want to overwrite
	doBkUsrChoice=$(checkBackUp "${addonBkFolder}${DATE}/${adName}" "1")
	if [ $doBkUsrChoice=""  ];then
		#backup the folder
		autoBackUp "${addonTab[0]}" "${addonBkFolder}/${DATE}/${adName}"
		#--BackUp Add-on mysql
		if [ ! ${addonTab[5]}="" ];then
			title "backup ${adName} MySQL databases" "3"
			mysqldump -u $msqlRootUser -p$msqlRootPass ${addonTab[5]} > "${addonBkFolder}/${DATE}/${adName}/${adName}.sql"
		fi
	fi
	
	#====[ UPDATE GIT FILES ]====#
	#--Update git files
	title "Update ${addonTab[1]} GIT files" "3"	
	#update git 
	updateGit "${FoldReqGit}/${addonTab[1]}" "${addonTab[2]}"
	#--choose a version in git
	chooseGitVersion ${FoldReqGit}/${addonTab[1]}
	#--Install dependencies
	cd ${FoldReqGit}/${addonTab[1]}
	if [ -f composer.json ];then
		title "Install dependencies" "3"
		#installing composer files
		curl -sS "$UrlReqComposer"| php		
		php composer.phar install
		php composer.phar update
	fi
	
	#====[ COPY UPDATED FILES ]====#
	#--copy files
	title "Copy ${adName} updated files" "3"
	cp -r ${FoldReqGit}/${addonTab[1]}/. ${addonTab[0]}
	#--clean git files
	title "Clean git files" "3"
	cleanGitFiles "${addonTab[0]}"
		
	#====[ RESOTRE CONFIG & RIGHTS ]====#
	if [ ! -z ${addonTab[3]} ];then
		#--Restoring configuration files
		title "Restoring configuration files" "3"	
		#create file array
		addonFileTab=(${addonTab[3]//|-_-|/ })
		# for each file in file list declaration
		for addonFile in ${addonFileTab[@]};do
			if [ -f ${addonBkFolder}/${DATE}/${adName}/$addonFile ];then
				cp -R ${addonBkFolder}/${DATE}/${adName}/$addonFile ${addonTab[0]}/$addonFile
			else
				mkdir -p ${addonTab[0]}/$addonFile
				cp -R ${addonBkFolder}/${DATE}/${adName}/$addonFile/. ${addonTab[0]}/$addonFile/
			fi
		done
	fi
	if [ ! -z ${addonTab[4]} ];then		
		#--Restoring files rights
		title "Restoring files rights" "3"
		#create file array
		addonRightsTab=(${addonTab[4]//|-_-|/ })
		# for each file in file list declaration
		for addonRights in ${addonRightsTab[@]};do
			chown $linuxWebUsr ${addonTab[0]}/$addonRights -R 
		done
		#set web user rights			
		chown $linuxWebUsr ${addonTab[0]} -R
	fi
	
	#====[ TODO EXTRA SCRIPT LAUNCH ]====#
	#like for update mysql...
	
done
