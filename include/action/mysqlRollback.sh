#mysqlrollback
newaction "rollback an older version...current files & data will be overwritten /!\ " "rollback MySQL & phpMyAdmin"

#read backup folder and list available backups (set $bk)
rollBackSelection ${FoldMySqlBK}

#phpMyAdmin
if [ -d "${FoldMySqlBK}/${bk}/${FoldOptMyAdmin##*/}" ];then
	title "Restore ${bk} files & folder" "2"
	cp -R ${FoldMySqlBK}/${bk}/${FoldOptMyAdmin##*/}/. ${FoldOptMyAdmin}
	good "file restored to ${FoldOptMyAdmin}"
fi

#mysql
title "Restore ${bk} database" "2"
check "root password is required"
mysql -u root -p < "${FoldMySqlBK}/${bk}/fullDB.sql"
good "database restored"