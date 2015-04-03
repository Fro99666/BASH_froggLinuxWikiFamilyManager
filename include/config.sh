#VarName Format (used for test.sh)
#FoldReq... 		requiered folder
#FoldOpt...			optional folder
#FileReq... 		requiered file
#FileOpt...			optional file
#urlReq... 			requiered url
#urlOpt...			optional url

#===MYSQL: used only for mysqlupdate/mysqlbackup/mysqlrollback case
msqlUser="xxxxx"									#[*]mysql super user
msqlPass="xxxxx"									#[*]mysql super user pass

#===CONFIG: used only for changepass case
#Linux root user
linuxRootUsr="root"	
#Collabtive config file
FoldConfCollabtive="/opt/web/collabtive/config/standard/config.php"
#Piwik config file
FoldConfPiwik="/opt/web/piwik/config/config.ini.php"

#===WIKIMEDIA: used for install/update/rollback/backup

#main App
FoldReqWiki="/opt/web/wiki"							#Wiki main folder
FoldReqGit="/opt/git"								#git main folder
FoldReqBackup="/opt/backup"							#backuped app folder
FoldOptMyAdmin="/opt/web/phpmyadmin"				#[*]phpMyAdmin main folder only for install/mysqlupdate/mysqlbackup/mysqlrollback

#wiki git stuff
FoldOptWikiGit="/opt/git/wiki.git"					#official git of mediawiki
FileGitDel=(".jscsrc" ".jshintignore" ".jshintrc" ".git" ".gitattributes" ".rubocop.yml" ".travis.yml" "Gemfile.lock" "Gemfile" "composer.json" "composer.lock" "composer.phar" "README" "README.mediawiki" "serialized" "docs" "FAQ" "HISTORY" "UPGRADE" "INSTALL" "COPYING" "CREDITS") #added "COPYING" "CREDITS" but i think they are used ...todo : check this ! + ".REALSE*" dont works ... removed ".rubocop_todo.yml"
													#list of git project files (or folders) to remove from prods wikiz
#Git Repositories Stuff
UrlReqWikiGit="https://gerrit.wikimedia.org/r/p/mediawiki/core.git"		#mediawiki git files
UrlReqComposer="https://getcomposer.org/installer"						#composer installer url
UrlReqMyAdminGit="https://github.com/phpmyadmin/phpmyadmin.git"			#phpmyadmin git files

#wiki stuff
FoldReqCommon="${FoldReqWiki}/common"					#wiki folder with common stuff in main folder (images,extensions,skins,maintenances,includes,...) -IMPORTANT :  without / at end
FileReqDbConf="${FoldReqWiki}/common/config_common.php"	#file where database infos are stored
shareDbPrefix="fr_"										#database shared in wiki 

#Linux Stuff
linuxWebUsr="www-data:www-data"						#Linux web user
requires=("curl" "git" "php" "mysql") 				#list of required stuff installed
