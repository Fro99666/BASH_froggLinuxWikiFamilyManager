#mysqlrollback
newaction "rollback an older version...current files & data will be overwritten /!\ " "rollback wiki data & files"

#read backup folder and list available backups (set $bk)
rollBackSelection ${FoldWikiBK}

#wikiez
title "Restore ${bk} files & folder" "2"
cp -R ${FoldWikiBK}/${bk}/. ${FoldReqWiki}
good "file restored to ${FoldReqWiki}"

#mysql
title "Restore ${bk} database" "2"
getMysqlInfo ${FoldWikiBK}/${bk}/${FileReqDbConf/${FoldReqWiki}/}
mysql -u ${msqlUser} -p${msqlPass} ${msqlWikiDb} < "${FoldWikiBK}/${bk}/${msqlWikiDb}.sql"
good "database restored"