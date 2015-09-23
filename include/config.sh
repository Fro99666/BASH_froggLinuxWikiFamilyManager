#VarName Format (used for test.sh)
#FoldReq... 		required folder
#FoldOpt...			optional folder
#FileReq... 		required file
#FileOpt...			optional file
#urlReq... 			required url
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
FileGitDel=(".jscsrc" ".jshintignore" ".jshintrc" ".git" ".gitattributes" ".gitignore" ".rubocop.yml" ".travis.yml" "Gemfile.lock" "Gemfile" "composer.lock" "composer.phar" "README" "README.mediawiki" "serialized" "docs" "FAQ" "AUTHORS" "CHANGELOG" "HISTORY" "UPGRADE" "INSTALL" "COPYING" "CREDITS" "LICENSE" ".rubocop_todo.yml" "INSTALL.md" "README.md" "DEVELOPERS.md" "LICENSE.txt" "jsduck.json" "pkg_builder" "tests" "Gruntfile.js" "licence.txt" "humans.txt" "package.json ")
													#list of git project files (or folders) to remove from prods wikiz
#Git Repositories Stuff
UrlReqWikiGit="https://gerrit.wikimedia.org/r/p/mediawiki/core.git"		#mediawiki git files
UrlReqComposer="https://getcomposer.org/installer"						#composer installer url
UrlReqMyAdminGit="https://github.com/phpmyadmin/phpmyadmin.git"			#phpmyadmin git files

#wiki stuff
FoldReqCommon="${FoldReqWiki}/common"					#wiki folder with common stuff in main folder (images,extensions,skins,maintenances,includes,...) -IMPORTANT :  without / at end
FileReqDbConf="${FoldReqWiki}/common/config_common.php"	#file where database infos are stored
siteMapFile="sitemap"									#folder generated for sitemap files
maintenanceFile="/errors/maintenance.htm"				#default page use to display maintenance while updating

#Linux Stuff
linuxWebUsr="www-data:www-data"						#Linux web user
requires=("curl" "git" "php" "mysql") 				#list of required stuff installed
htaFile=".htaccess"									#htaccess file

#===ADDON: optional used to manage exta web site if they are installed
declare -a addonList
#addons List
addonList[0]="/opt/web/log|@_@|PimpMyLog|@_@|github.com/potsky/PimpMyLog.git|@_@|config.user.php|-_-|config.auth.user.php|-_-|robots.txt|@_@||@_@|"
addonList[1]="/opt/web/info|@_@|linfo|@_@|github.com/jrgp/linfo.git|@_@|robots.txt|@_@||@_@||@_@|"
addonList[2]="/opt/web/project|@_@|Collabtive|@_@|github.com/philippK-de/Collabtive.git|@_@|config/standard/config.php|-_-|robots.txt|-_-|files|@_@|files|@_@|collabtive"
addonList[3]="/opt/web/git|@_@|gitlist|@_@|github.com/klaussilveira/gitlist.git|@_@|config.ini|-_-|robots.txt|@_@||@_@|"
#addons BackUp Folder
addonBkFolder=${FoldReqBackup}/addon/

#each are separate by |@_@| to FakeArray (string can't contain : who is used as array separator)
#0 web path
#1 git path
#2 remote master git url
#3 file & folder to restore (FakeArray separator = |-_-|)
#4 www-data rights to restore as 750 (FakeArray separator = |-_-|)
#5 mysql database
