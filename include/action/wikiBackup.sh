#mysqlbackup
newaction "start the prod wiki backup (files & database)" "Backup wikiez files & database"

#check if backup already exist
checkBackUp ${CurrFoldWikiBK}

#Backup files
# ------------------
title "Backup Files" "2"
autoBackUp "${FoldReqWiki}" "${CurrFoldWikiBK}"

#Backup Mysql Database
# --------------------
title "Backup Database" "2"
mkdir -p "${CurrFoldWikiBK}/"
mysqldump -u ${msqlWikiUser} -p${msqlWikiPass} ${msqlWikiDb} > "${CurrFoldWikiBK}${msqlWikiDb}.sql"
good "wiki database backuped to ${CurrFoldWikiBK}${msqlWikiDb}.sql"


