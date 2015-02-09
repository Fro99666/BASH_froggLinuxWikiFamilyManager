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
SCV="0.101"                    # script version
SCO="2014/11/18"               # script date creation
SCU="2015/02/09"               # script last modification
SCA="Frogg"                    # script author
SCM="admin@frogg.fr"           # script author Mail
SCP=$PWD                       # script path
SCY="2015"                     # script copyrigth year
# ############################ #

# TODO [1] : Install (with skin/ext management/Conf creator) + piwik & piwik plugin in

# gestion des passwords
# collabtive update

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
. ${act}mysqlBackup.sh;;
$doMYUP)	#Case -mysqlupdate
. ${act}mysqlBackup.sh
. ${act}mysqlUpdate.sh;;
$doMYRB)	#Case -mysqlrollback
. ${act}mysqlRollback.sh;;
$doWIBK)	#Case -backup
. ${act}wikiBackup.sh;;
$doWIRB)	#Case -rollback
. ${act}wikiRollback.sh
. ${act}wikiConfig.sh;;
$doWIIN)	#Case -install
echo "TODO:@WORK !!";;
$doWIUP)	#Case -update
. ${act}wikiBackup.sh
. ${act}wikiGit.sh
. ${act}wikiUpdate.sh
. ${act}wikiConfig.sh;;
esac

# RESULT
# ======
title "Script Results" "1"
good "...Script process is over...Congratz !"