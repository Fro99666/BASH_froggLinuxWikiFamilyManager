#Wiki update
newaction "start the prod wiki update (files & database)" "Install/Update all wikiez files & database"

# Extra maintenance func
# ----------------------
#create a tmp redirect htaccess
createTmpHtaccess()
{
echo "#Redirect trafic to maintenance page" > ${1}/${htaFile}
echo "RewriteEngine on" >> ${1}/${htaFile}
echo "RewriteCond %{REQUEST_URI} !/${maintenanceFile}$ [NC]" >> ${1}/${htaFile}
echo "RewriteRule \".*\" \"${maintenanceFile}\" [R=302,L]" >> ${1}/${htaFile}
#RewriteRule "(.*\/wiki)\/.*" "$1/maintenance.htm" [R=302,L] <<apache 2.4 won't let this work ?
#OR
#RewriteBase /wiki/
#RewriteRule ".*" "maintenance.htm" [R=302,L] <<apache 2.4 won't let this work ?
echo "#Remove Cache" >> ${1}/${htaFile}
echo "Header set Cache-Control \"max-age=0, no-cache, no-store, must-revalidate\"" >> ${1}/${htaFile}
echo "Header set Pragma \"no-cache\"" >> ${1}/${htaFile}
echo "Header set Expires \"Sat, 02 Aug 1980 15:15:00 GMT\"" >> ${1}/${htaFile}
}

#Add temp page while updating
#addMaintenancePage()
#{
#cp ${fil}/${maintenanceFile} ${1}/${maintenanceFile}
#if [ -z ${2} ];then
#	title "adding maintenance page ${1}/${maintenanceFile}" "3"
#	#move .htaccess if exist
#	if [ -f ${1}/${htaFile} ];then
#		mv ${1}/${htaFile} ${1}/${htaFile}.old
#	fi
#fi
#createTmpHtaccess "${1}"
#}

#remove temp page after updating
removeMaintenancePage()
{
title "removing maintenance page for ${1}" "3"
#rm ${1}/${maintenanceFile}
#restore .htaccess if exist else remove temp .htaccess
if [ -f ${1}/${htaFile}.old ];then
	mv ${1}/${htaFile}.old ${1}/${htaFile}
else
	if [ -f ${1}/${htaFile} ];then
		rm ${1}/${htaFile}
	fi
fi
}

# set maintenance page
# --------------------
title "adding maintenance page" "2"

for lang in ${FoldReqWiki}/*;do
	createTmpHtaccess "${lang}"
	#addMaintenancePage "${lang}"
done

# update maintenance folder
# -------------------------
title "Update maintenance,includes,languages,vendor folders" "2"
cp -r  "${FoldOptWikiGit}/maintenance/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/includes/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/languages/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/vendor/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/mw-config/" ${FoldReqCommon}
cp -r  "${FoldOptWikiGit}/resources/" ${FoldReqCommon} 

title "Update common files" "2"
cp "${FoldOptWikiGit}/autoload.php" ${FoldReqCommon}
cp "${FoldOptWikiGit}/composer.json" ${FoldReqCommon}
cp "${FoldOptWikiGit}/composer.lock" ${FoldReqCommon}

# update extensions & Skins
# -------------------------
if [ $doWIUP = 1 ];then
	#Only for update case !
	makeachoice "update skins & extensions (optional)"
	if [ $? = 1 ];then
		title "Update Skins & Extensions" "2"
		# update extensions
		title "Update Extensions" "3"
		updateGitFolders "${FoldReqCommon}extensions/"
		doAllComposer "${FoldReqCommon}extensions/"
		# update Skins
		title "Update Skins" "3"
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
		#addMaintenancePage "${lang}" "false"
		
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
title "removing maintenance page" "2"
for lang in ${FoldReqWiki}*;do
	removeMaintenancePage "${lang}"
done