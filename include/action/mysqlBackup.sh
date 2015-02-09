#mysqlbackup
newaction "backup Mysql & phpMyadmin files" "backup MySQL & phpMyAdmin"

#Test if phpMyadmin is installed
[ -d "${FoldOptMyAdmin}" ] && hasMyAdmin=1 || hasMyAdmin=0

#check if backup already exist
checkBackUp ${CurrFoldMySqlBK}
#BackUp mySQL
title "backup full MySQL databases" "2"
check "root password is required"
mysqldump -u root -p --all-databases > "${CurrFoldMySqlBK}fullDB.sql"
good "full database backuped to ${CurrFoldMySqlBK}fullDB.sql"

#BackUp phpMyAdmin
title "backup phpMyAdmin files" "2"
FoldMyAdmin=${FoldOptMyAdmin%?}
[ $hasMyAdmin = 1 ] && autoBackUp "${FoldMyAdmin}" "${CurrFoldMySqlBK}${FoldMyAdmin##*/}" || check "phpMyAdmin is not installed"
