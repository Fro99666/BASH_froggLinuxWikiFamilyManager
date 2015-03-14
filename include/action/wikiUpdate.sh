#mysqlupdate
newaction "start the prod wiki update (files & database)" "Update all wikiez files & database"

# update maintenance folder
# -------------------------
title "Update maintenance,includes,languages,vendor folders" "1"
cp -r  "${FoldOptWikiGit}/maintenance/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/includes/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/languages/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/vendor/" ${FoldReqCommon}
cp "${FoldOptWikiGit}/autoload.php" ${FoldReqCommon}

# update extensions & Skins
# -------------------------
makeachoice "update skins & extensions (optional)"
if [ $? = 1 ];then
	title "Update Skins & Extensions" "1"
	# update extensions
	title "Update Extensions" "2"
	updateGitFolders "${FoldReqCommon}extensions/"
	# update Skins
	title "Update Skins" "2"
	updateGitFolders "${FoldReqCommon}skins/" "common"
fi

# Doing stuff for each lang
# -------------------------
for lang in ${FoldReqWiki}*;do

	if [ ! "${lang}/" = $FoldReqCommon -a -d $lang ];then

		#just the folder name
		shortLang=${lang##*/}

		title "Case Wiki ${shortLang}" "2"

		# create each wikiz
		# -----------------
		title "Copying files for ${shortLang}" "3"
		rm -r $lang
		mkdir $lang
		cp -r ${FoldOptWikiGit}. ${lang}
		good "Last official mediawiki files has been copied to ${lang}"
		#clean git files
		cleanGitFiles "${lang}"
		good "${lang} git file has been cleaned"

		# restore settings
		# -----------------
		title "Restore settings" "3"
		cp "${CurrFoldWikiBK}/${shortLang}/LocalSettings.php" ${lang}
		good "LocalSettings.php as been restored"

		# set common folder links
		# -----------------------
		title "Link to common" "3"
		for comFold in ${FoldReqCommon}*;do
			if [ -d $comFold ];then
				rm -r "${lang}/${FoldReqCommon##*/}${comFold##*/}"
				ln -s "${comFold}" "${lang}/${FoldReqCommon##*/}${comFold##*/}"
				good "${comFold} folder has been linked to ${lang}/${FoldReqCommon##*/}${comFold##*/}"
			fi
		done

		# update database
		# ---------------
		title "Database update" "3"
		php "${lang}/maintenance/update.php --conf ${lang}/LocalSettings.php"
		good "${lang} database has been updated"

	fi

done
