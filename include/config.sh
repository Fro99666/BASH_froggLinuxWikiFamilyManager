#VarName Format (used for test.sh)
#FoldReq... 		requiered folder
#FoldOpt...			optional folder
#FileReq... 		requiered file
#FileOpt...			optional file
#urlReq... 			requiered url
#urlOpt...			optional url

#===Const (this part can be changed by user)

#PARAMS Mysql Wiki
msqlWikiDb="wiki"									#wiki database name
msqlUser="root"										#mysql user
msqlPass="xxxx"										#mysql pass

FoldReqOrigin="/opt"								#All App Folder

#main App
FoldOptMyAdmin="/opt/phpmyadmin"					#phpMyAdmin main folder
FoldReqWiki="/opt/wiki"								#Wiki main folder
FoldReqGit="/opt/git"								#git main folder
FoldReqBackup="/opt/backup"							#backuped app folder

#wiki git stuff
FoldOptWikiGit="/opt/git/wiki.git"					#official git of mediawiki
FileGitDel=(".js*" ".git*" ".rub*" ".trav*" "Gemfile*" "README*" "RELEASE*" "composer*" "serialized" "docs" "FAQ" "HISTORY" "UPGRADE" "INSTALL")
													#list of git project files (or folders) to remove from prods wikiz
#Git Repositories Stuff
UrlReqWikiGit="https://gerrit.wikimedia.org/r/p/mediawiki/core.git"		#mediawiki git files
UrlReqComposer="https://getcomposer.org/installer"						#composer installer url
UrlReqMyAdmin="https://github.com/phpmyadmin/phpmyadmin.git"			#phpmyadmin git files

#wiki stuff
FoldReqCommon="/opt/wiki/common"					#wiki folder with common stuff in main folder (images,extensions,skins,includes,...) -IMPORTANT :  without / at end
FileReqDbConf="/opt/wiki/common/config_common.php"	#file where database infos are stored

#Linux Stuff
linuxWebUsr="www-data:www-data"						#Linux web user
requires=("curl" "git" "php" "mysql") 				#list of required stuff installed