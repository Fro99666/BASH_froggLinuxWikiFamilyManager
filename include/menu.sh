#===Vars
z=0												#title lvl 1
y=0												#title lvl 2
x=0												#title lvl 3
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
doMYUP=0 #do MysqlUpdate only
doMYRB=0 #do MysqlRollBack only
doPASS=0 #do Change Pass only
for params in $*
do
	IFS=: val=($params)
	case ${val[0]} in
		"-install")doWIIN=1;break;;
		"-update")doWIUP=1;break;;
		"-rollback")doWIRB=1;break;;
		"-backup")doWIBK=1;break;;
		"-mysqlupdate")doMYUP=1;break;;
		"-mysqlbackup")doMYBK=1;break;;
		"-mysqlrollback")doMYRB=1;break;;
		"-changepass")doPASS=1;break;;
		*)doWIBK=1;break;;
	esac
done

#reformat folder vars
FoldReqOrigin=$(addSlashToFold "$FoldReqOrigin")
FoldReqCommon=$(addSlashToFold "$FoldReqCommon")
FoldReqBackup=$(addSlashToFold "$FoldReqBackup")
FoldReqWiki=$(addSlashToFold "$FoldReqWiki")
FoldReqGit=$(addSlashToFold "$FoldReqGit")
FoldOptMyAdmin=$(addSlashToFold "$FoldOptMyAdmin")
FoldOptWikiGit=$(addSlashToFold "$FoldOptWikiGit")
