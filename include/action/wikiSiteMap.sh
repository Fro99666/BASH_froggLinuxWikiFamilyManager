#ask user for edit script config
makeachoice "generate Mediawiki sitemap.xml"
if [ $? = 0 ]; then
	warn "exit script, cancelled by user"
	exit
fi

title "Create each sitemap.xml" "1"

# Doing stuff for each lang
# -------------------------
for lang in ${FoldReqWiki}*;do

	if [ ! "${lang}/" = $FoldReqCommon -a -d $lang ];then
	
		#just the folder name
		shortLang=${lang##*/}
		title "Generate site map ${shortLang}" "2"
		
		cd $lang
		
		#get wiki web folder
		tmpCat=$(cat LocalSettings.php)
		scriptPath=`echo "$tmpCat" | grep "wgScriptPath" | cut -d \" -f 2`
		
		#get wiki web url
		#tmpCat=$(cat ${FileReqDbConf})
		scriptUrl=`echo "$tmpCat" | grep "wgServer" | cut -d \" -f 2`		
		#get wiki web url
		scriptUrl=`echo ${scriptUrl}| tr -d '\n'`
		scriptFullUrl=$scriptUrl
		scriptUrl=${scriptUrl/http:\/\//}
		scriptUrl=${scriptUrl/https:\/\//}

		#Create sitemap folder
		mkdir -p ${siteMapFile}
		
		#generate sitemap
		php maintenance/generateSitemap.php \
			--fspath ${siteMapFile} \
			--server "${scriptUrl}" \
			--urlpath "${scriptUrl}${scriptPath}/${siteMapFile}" \
			--conf LocalSettings.php

		#move sitemap to sitemal.xml in root folder
		siteMapGen=$(echo ${siteMapFile}/*.xml)
		cp $siteMapGen sitemap.xml
	
		#add robots.txt
		if [ ! -e "robots.txt" ];then
			echo -e "User-agent: *\nAllow: /\n" > robots.txt
			echo "sitemap: ${scriptFullUrl}${scriptPath}/sitemap.xml" >> robots.txt
			#set web user rights
			chown "$linuxWebUsr" ${siteMapFile} -R
			chown "$linuxWebUsr" sitemap.xml
		else
			warn "${shortLang}/robots.txt not created: already exist"
			warnList="${warnList}\n- ${shortLang}/robots.txt not created: already exist"
		fi
	fi
done
