#mysqlupdate
newaction "start Mysql & phpMyadmin install/update" "install/update MySQL & phpMyAdmin"

#Install/update mySQL
title "update MySQL" "2"
apt-get install mysql-server -y

#Install/update phpMyAdmin
title "update phpMyAdmin" "2"

#update/install myAdmin.git
updateGit "${FoldOptMyAdmin}" "${UrlReqMyAdminGit}"
#set rights
chown "$linuxWebUsr" ${FoldOptMyAdmin} -R
#choose a version in git
chooseGitVersion ${FoldOptMyAdmin}
