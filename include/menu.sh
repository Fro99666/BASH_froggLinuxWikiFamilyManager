#===Vars
z=0												#title lvl 1
y=0												#title lvl 2
x=0												#title lvl 3
warnList=""										#list of warn in script
errFound=0										#tests error count
FoldWikiBK=${FoldReqBackup}/${FoldReqWiki##*/}	#Fold wiki for backup
FoldMySqlBK="${FoldReqBackup}/mysql" 			#Fold mysql for backup
DATE=`date '+%Y%m%d'`							#date to format AAAAMMJJ
CurrFoldWikiBK="${FoldWikiBK}/${DATE}/"			#Fold wiki backup for now
CurrFoldMySqlBK="${FoldMySqlBK}/${DATE}/"		#Fold mysql backup for now

# SCRIPT Menu
# ===========
doWIIN=0 #do Wiki Install only
doWIUP=0 #do Wiki Update only
doWIRB=0 #do Wiki RollBack only
doWIBK=0 #do Wiki BackUp only
doSMAP=0 #do Wiki sitemap
doWHTA=0 #do Wiki htaccess
doMYUP=0 #do MysqlUpdate only
doMYRB=0 #do MysqlRollBack only
doPASS=0 #do Change Pass only
doADUP=0 #do add-on update
doADRB=0 #do add-on roll back
doAUTO=0 #do auto confirm

params=($*)
for param in ${params[@]}
do
	case ${param} in
		"-install")		doWIIN=1;;
		"-update")		doWIUP=1;;
		"-rollback")		doWIRB=1;;
		"-backup")		doWIBK=1;;
		"-mysqlupdate")		doMYUP=1;;
		"-mysqlbackup")		doMYBK=1;;
		"-mysqlrollback")	doMYRB=1;;
		"-changepass")		doPASS=1;;
		"-sitemap")		doSMAP=1;;
		"-htaccess")		doWHTA=1;;
		"-addonupdate")		doADUP=1;;
		"-addonrollback")	doADRB=1;;
		"-confirm")		doAUTO=1;;
	esac
done

#default case update auto (use by me but optional can be removed to not be auto-started)
if [ -z "${*}" ];then
	doWIUP=1
	doADUP=1
	doAUTO=1
fi

#if change pass is chosen, auto-validation can't be set to 1
if [ $doPASS = 1 ]; then
 doAUTO=0
fi

#reformat folder vars
FoldReqCommon=$(addSlashToFold "$FoldReqCommon")
FoldReqBackup=$(addSlashToFold "$FoldReqBackup")
FoldReqWiki=$(addSlashToFold "$FoldReqWiki")
FoldReqGit=$(addSlashToFold "$FoldReqGit")
FoldOptMyAdmin=$(addSlashToFold "$FoldOptMyAdmin")
FoldOptWikiGit=$(addSlashToFold "$FoldOptWikiGit")
