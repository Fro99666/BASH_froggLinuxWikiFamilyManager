#mysqlupdate
newaction "start Mysql & phpMyadmin update" "update MySQL & phpMyAdmin"

#Install/update mySQL
title "update MySQL" "2"
apt-get install mysql-server -y

#Install/update phpMyAdmin
title "update phpMyAdmin" "2"
if [ $hasMyAdmin = 1 ]; then
	updateGit ${FoldOptMyAdmin} ${UrlReqMyAdmin}
	#set rights
	chown "$linuxWebUsr" ${FoldOptMyAdmin} -R
	#choose a version in git
	cd ${FoldOptMyAdmin}
	chooseGitVersion
else
	check "phpMyAdmin is not installed"
fi