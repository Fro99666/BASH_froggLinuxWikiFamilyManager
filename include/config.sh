#VarName Format (used for test.sh)
#FoldReq... 		requiered folder
#FoldOpt...			optional folder
#FileReq... 		requiered file
#FileOpt...			optional file
#urlReq... 			requiered url
#urlOpt...			optional url

#===Const (this part can be changed by user)

#PARAMS Mysql Wiki
msqlUser="root"										#mysql super user
msqlPass="xxxx"										#mysql super user pass

FoldReqOrigin="/opt"								#All App Folder

#main App
FoldOptMyAdmin="/opt/web/phpmyadmin"				#phpMyAdmin main folder
FoldReqWiki="/opt/web/wiki"							#Wiki main folder
FoldReqGit="/opt/git"								#git main folder
FoldReqBackup="/opt/backup"							#backuped app folder

#wiki git stuff
FoldOptWikiGit="/opt/git/wiki.git"					#official git of mediawiki
FileGitDel=(".jscsrc" ".jshintignore" ".jshintrc" ".git" ".gitattributes" ".rubocop_todo.yml" ".rubocop.yml" ".travis.yml" "Gemfile.lock" "Gemfile" "composer.json" "composer.lock" "composer.phar" "README" "README.mediawiki" "serialized" "docs" "FAQ" "HISTORY" "UPGRADE" "INSTALL" "COPYING" "CREDITS") #added "COPYING" "CREDITS" but i think they are used ...todo : check this ! + ".REALSE*" dont works ...
													#list of git project files (or folders) to remove from prods wikiz
#Git Repositories Stuff
UrlReqWikiGit="https://gerrit.wikimedia.org/r/p/mediawiki/core.git"		#mediawiki git files
UrlReqComposer="https://getcomposer.org/installer"						#composer installer url
UrlReqMyAdmin="https://github.com/phpmyadmin/phpmyadmin.git"			#phpmyadmin git files

#wiki stuff
FoldReqCommon="/opt/web/wiki/common"					#wiki folder with common stuff in main folder (images,extensions,skins,maintenances,includes,...) -IMPORTANT :  without / at end
FileReqDbConf="/opt/web/wiki/common/config_common.php"	#file where database infos are stored

#Linux Stuff
linuxRootUsr="root"									#Linux root user
linuxWebUsr="www-data:www-data"						#Linux web user
requires=("curl" "git" "php" "mysql") 				#list of required stuff installed
