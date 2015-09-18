#Wiki update
newaction "start the prod wiki update (files & database)" "Install/Update all wikiez files & database"

#Add temp page while updating
addMaintenancePage()
{
echo "<center>Frogg Media Wiki is under maintenance,<br>the web site is being updated,<br>please check again later ...</center>" > $1
}

# set maintenance page
# --------------------
for lang in ${FoldReqWiki}*;do
	title "adding maintenance page ${lang}\${apacheFirstPage}" "1"
	addMaintenancePage ${lang}\${apacheFirstPage}
done

# update maintenance folder
# -------------------------
title "Update maintenance,includes,languages,vendor folders" "1"
cp -r  "${FoldOptWikiGit}/maintenance/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/includes/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/languages/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/vendor/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/mw-config/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/resources/" ${FoldReqCommon} 

title "Update common files" "1"
cp "${FoldOptWikiGit}/autoload.php" ${FoldReqCommon}
cp "${FoldOptWikiGit}/composer.json" ${FoldReqCommon}
cp "${FoldOptWikiGit}/composer.lock" ${FoldReqCommon}

# update extensions & Skins
# -------------------------
if [ $doWIUP = 1 ];then
	#Only for update case !
	makeachoice "update skins & extensions (optional)"
	if [ $? = 1 ];then
		title "Update Skins & Extensions" "1"
		# update extensions
		title "Update Extensions" "2"
		updateGitFolders "${FoldReqCommon}extensions/"
		doAllComposer "${FoldReqCommon}extensions/"
		# update Skins
		title "Update Skins" "2"
		updateGitFolders "${FoldReqCommon}skins/"
	fi
fi

# Doing stuff for each lang
# -------------------------
for lang in ${FoldReqWiki}*;do

	if [ ! "${lang}/" = $FoldReqCommon -a -d ${lang} ];then

		#just the folder name
		shortLang=${lang##*/}

		title "Case Wiki ${shortLang}" "2"

		# create each wikiz
		# -----------------
		title "Copying files for ${shortLang}" "3"
		rm -r ${lang}
		mkdir ${lang}
		#Add temp page while updating (removed from rm -r previously)
		addMaintenancePage ${lang}\${apacheFirstPage}
		
		cp -r ${FoldOptWikiGit}. ${lang}
		good "Last official mediawiki files has been copied to ${lang}"
		#clean git files
		cleanGitFiles "${lang}"
		good "${lang} git file has been cleaned"
		
		#Only for update case !
		if [ $doWIUP = 1 ];then		
			# restore settings
			# -----------------
			title "Restore settings" "3"
			cp "${CurrFoldWikiBK}/${shortLang}/LocalSettings.php" ${lang}
			good "LocalSettings.php as been restored"
		fi
		
		# set common folder links
		# -----------------------
		title "Link to common" "3"
		for comFold in ${FoldReqCommon}*;do
			if [ -d ${comFold} ];then
				rm -r "${lang}/${FoldReqCommon##*/}${comFold##*/}"
				ln -s "${comFold}" "${lang}/${FoldReqCommon##*/}${comFold##*/}"
				good "${comFold} folder has been linked to ${lang}/${FoldReqCommon##*/}${comFold##*/}"
			fi
		done

		#Only for update case !
		if [ ${doWIUP} = 1 ];then	
			# update database
			# ---------------
			title "Database update" "3"
			php ${lang}/maintenance/update.php --conf ${lang}/LocalSettings.php
			good "${lang} database has been updated"
		fi
	fi
	
done

# remove maintenance page
# -----------------------
for lang in ${FoldReqWiki}*;do
	title "removing maintenance page ${lang}\${apacheFirstPage}" "1"
	rm ${lang}\${apacheFirstPage}
done