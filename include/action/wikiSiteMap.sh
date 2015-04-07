#ask user for edit script config
makeachoice "generate Mediawiki site map"
if [ $? = 0 ]; then
	warn "exit script, cancelled by user"
	exit
fi

title "Create each site map" "1"

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
		tmpCat=$(cat ${FileReqDbConf})
		scriptUrl=`echo "$tmpCat" | grep "wgServer" | cut -d \" -f 2`		
		
		mkdir -p ${FoldOptGenSiteMap}
		php maintenance/generateSitemap.php --fspath ${FoldOptGenSiteMap} --server ${scriptUrl}${scriptPath} --urlpath ${scriptUrl}${scriptPath}/${FoldOptGenSiteMap} --conf LocalSettings.php

		siteMapGen=$(echo ls ${FoldOptGenSiteMap}/*.xml)
		mv $siteMapGen sitemap.xml
	
	fi
done