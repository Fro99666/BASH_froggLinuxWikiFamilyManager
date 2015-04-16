#If the add-on list is defined !
if [ -n $addonList ];then

	#addon rollback
	newaction "roll-back add-ons to an older version...current files & data will be overwritten /!\ " "roll-back add-on data & files"

	# for each add-on in add-on list declaration
	for addon in ${addonList[@]};do

		#get add-on full info
		addonTab=(${addon//|@_@|/ })
		#get folder name from full path
		adName=${addonTab[0]##*/}	
	
		#read backup folder and list available backups (set $bk)
		rollBackSelection ${addonBkFolder}

		#for each add-on (could be overwrite all, but user can user specific restore
		for addonBK in ${addonBkFolder}/${bk}/;do
		
			makeachoice "restore ${bk} ${adName}"
			if [ $? = 1 ]; then
			
				#files
				title "Restore ${bk} ${adName} files & folder" "2"
				cp -R ${addonBK}/. ${addonTab[0]}
				chown $linuxWebUsr ${addonTab[0]} -R

				#mysql
				if [ -f ${addonBkFolder}/${bk}/${adName}.sql ];then
					title "Restore ${bk} ${adName} database" "2"
					mysql -u ${msqlWikiUser} -p${msqlWikiPass} ${msqlWikiDb} < "${addonBkFolder}/${bk}/${adName}.sql"
				fi
			
			fi
			
		done
		
		
	done

fi
