#add dependencies {foldersInFolder} 
doAllComposer()
{
#for each folders
for currFold in ${1}*;do
 doComposer ${currFold}
done
}

#add dependencies {folder} 
doComposer()
{
#if composer is there, update it
if [ -f "composer.json" ];then
	# Install dependencies
	# ---------------------
	title "Install dependencies" "3"
	cd ${1}
	curl -sS "${UrlReqComposer}"| php
	php composer.phar install
	php composer.phar update
fi
}