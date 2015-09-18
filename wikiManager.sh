#!bin/bash/

# ############################ #
#            _ __ _            #
#        ((-)).--.((-))        #
#        /     ''     \        #
#       (   \______/   )       #
#        \    (  )    /        #
#        / /~~~~~~~~\ \        #
#   /~~\/ /          \ \/~~\   #
#  (   ( (            ) )   )  #
#   \ \ \ \          / / / /   #
#   _\ \/  \.______./  \/ /_   #
#   ___/ /\__________/\ \___   #
# ############################ #
SCN="LinuxWikiFamilyManager"   # script name
SCD="Install/Update/BackUp/RollBack WikiFamily project"
                               # script description
SCT="Debian"                   # script OS Test
SCC="bash $0"		           # script call
SCV="0.107"                    # script version
SCO="2014/11/18"               # script date creation
SCU="2015/08/28"               # script last modification
SCA="Frogg"                    # script author
SCM="admin@frogg.fr"           # script author Mail
SCP=$PWD                       # script path
SCY="2014-2015"                # script copyrigth year
# ############################ #

# TODO [1] : Compress Backup
# TODO [1] : Save phpmyadmin config

#Script Includes
#---------------
inc="${SCP}/include/"
fnc="${inc}function/"
act="${inc}action/"

#Include file Cleaning
#---------------------

# clean "<<1/4*" from file
unBom()
{
iconv -c -f utf8 -t ISO88591 $1 | iconv -f ISO88591 -t utf8 > temp.$$ && mv temp.$$ $1;
}

#clean ^M
unCtrlM()
{
tr -d '\r' < $1 > temp.$$ && mv temp.$$ $1
}

#clean all files from
cleanDir()
{
for file in $1/*;do
	if [ -f $file ];then
		unBom $file;unCtrlM $file
	else
		cleanDir $file
	fi
done
}

# SCRIPT PREPARE
# ==============
#Cleaning
cleanDir ${inc}
#Params
. ${inc}config.sh
#Functions
. ${fnc}color.sh
. ${fnc}com.sh
. ${fnc}func.backup.sh
. ${fnc}func.git.sh
. ${fnc}func.composer.sh
. ${fnc}func.mysql.sh
. ${fnc}func.php.sh
#Menu
. ${inc}menu.sh
#Test if all is ok
. ${act}test.sh

# START SCRIPT
# ============
case 1 in
$doMYBK)	#Case -mysqlbackup
. ${act}mysqlBackup.sh
;;&
$doMYUP)	#Case -mysqlupdate
. ${act}mysqlBackup.sh
. ${act}mysqlUpdate.sh
;;&
$doMYRB)	#Case -mysqlrollback
. ${act}mysqlRollback.sh
;;&
$doADUP)	#Case -addonupdate
. ${act}addonBackup.sh
;;&
$doADRB)	#Case -addonrollback
. ${act}addonRollback.sh
;;&
$doWIBK)	#Case -backup
. ${act}wikiBackup.sh
;;&
$doWIRB)	#Case -rollback
. ${act}wikiRollback.sh
. ${act}wikiConfig.sh
;;&
$doWIIN)	#Case -install
. ${act}wikiInfo.sh
. ${act}mysqlUpdate.sh
. ${act}wikiGit.sh
. ${act}wikiUpdate.sh
. ${act}wikiConfig.sh
. ${act}wikiSiteMap.sh
. ${act}wikiHtaccess.sh
;;&
$doWIUP)	#Case -update
. ${act}wikiBackup.sh
. ${act}wikiGit.sh
. ${act}wikiUpdate.sh
. ${act}wikiConfig.sh
. ${act}wikiSiteMap.sh
. ${act}wikiHtaccess.sh
;;&
$doPASS)	#Case -changepass
. ${act}changePass.sh
;;&
$doSMAP)	#Case -sitemap
. ${act}wikiSiteMap.sh
;;&
$doWHTA)	#Case -htaccess
. ${act}wikiHtaccess.sh
;;
esac

# RESULT
# ======
title "Script Results" "1"
good "...Script process is over...Congratz !"
if [[ -n $warnList ]];then
	warn "some task encounter troubles:${warnList}"
fi

#Only for install case !
if [ $doWIIN = 1 ];then
	#si file not exist
	touch $FileReqDbConf
	good ""
	good "You need to set a link in you web configuration to ${lang}"
	good "for example (easy way):" 
	good "ln -s /var/www/{lang} {pathToWikiLang}"
	good ""
	good "to finish the install display Wikimedia installed web site in your browser"
	good "once done, modify $FileReqDbConf to add Wiki database config and add a link to this file into your LocalSetting.php of each languages installed "
	good ""
	good "for more infos got to http://en.wiki.frogg.fr/index.php/Wikimedia or http://wiki.frogg.fr/index.php/Wikimedia"
fi
