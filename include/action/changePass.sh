# ========= PASSWORD
title "choose and change admin users password" "1"

#===LINUX
title "Linux password" "2"
# warn of action and ask if user is sure
makeachoice "change password for Linux [$linuxRootUsr] user"
if [ $? = 1 ]; then
	passwd $linuxRootUsr
	#Method 0
	#passwd $sa
	#Method 1
	#openssl passwd -1 -salt xyz  yourpass
	#Method 2
	#makepasswd --clearfrom=- --crypt-md5 <<< YourPass
	#Method 3
	#echo -e "md5crypt\npassword" | grub | grep -o "\$1.*"
else
	warn " [ A ] skipped by user"
fi

#===WIKI
title "Wiki passwords" "2"
# warn of action and ask if user is sure
userName=$(getMysqlWikiUserName)
makeachoice "change password for [$userName] Wiki root user login"
if [ $? = 1 ]; then
	read -p " [ Q ] Type new password for user [$userName]: " newpass
	makeachoice "change [$userName] password for [$newpass]"
	if [ $? = 1 ]; then
		reqres=$(php $FoldReqCommon/maintenance/changePassword.php --user=$userName --password=$newpass --conf=${FoldReqWiki}/pool/LocalSettings.php)
		if [ ! ${reqres//Password set for/} = ${reqres} ];then
			good " [ A ] [$userName] new pass is [$newpass]"
		else
			err " [ A ] an error occurred"
		fi
	else
		warn " [ A ] cancelled by user"
	fi
else
	warn " [ A ] skipped by user"	
fi

# warn of action and ask if user is sure
makeachoice "change mysql [$msqlWikiDb] database user [$msqlWikiDbUsr] password"
if [ $? = 1 ]; then
	read -p " [ Q ] Type new password for user [$msqlWikiDbUsr]: " newpass
	makeachoice "change [$msqlWikiDbUsr] password for [$newpass]"
	if [ $? = 1 ]; then
		if changeMysqlUserPass ${msqlWikiDbUsr} $newpass $msqlWikiUser $msqlWikiPass; then
			sed -i -e "/\$wgDBpassword / s/ .*/ = \"$newpass\";/" 	$FileReqDbConf
			good " [ A ] [$msqlWikiDbUsr] new pass is [$newpass]"
		else
			err " [ A ] an error occurred"
		fi
	else
		warn " [ A ] cancelled by user"
	fi
else
	warn " [ A ] skipped by user"	
fi

#===[BONUS] COLLABTIVE
if [ -n $FoldConfCollabtive ];then
	title "Collabtive passwords" "2"
	#get mysql infos
	getCollabtiveMysqlInfo $FoldConfCollabtive
	# warn of action and ask if user is sure
	userName=$(getMysqlCollabtiveUserName)
	makeachoice "change password for [$userName] Collabtive root user login"
	if [ $? = 1 ];then
		read -p " [ Q ] Type new password for user [$userName]: " newpass
		makeachoice "change [$userName] password for [$newpass]"
		if [ $? = 1 ];then
			hashPass=$(echo -n "$newpass" | openssl dgst -sha1)
			hashPass=${hashPass//(stdin)= } 
			if updateMysqlCollabtiveUserName $userName $hashPass;then
				good " [ A ] [$userName] new pass is [$newpass]"
			else
				err " [ A ] an error occurred"
			fi
		else
			warn " [ A ] cancelled by user"
		fi
	else
		warn " [ A ] skipped by user"	
	fi

	# warn of action and ask if user is sure
	makeachoice "change Collabtive database [$msqlCollabtiveDb] password for user [$msqlCollabtiveUser]"
	if [ $? = 1 ]; then
		read -p " [ Q ] Type new password for user [$msqlCollabtiveUser]: " newpass
		makeachoice "change [$msqlCollabtiveDb] password for [$newpass]"
		if [ $? = 1 ]; then
			if changeMysqlUserPass ${msqlCollabtiveUser} $newpass ${msqlCollabtiveUser} ${msqlCollabtivePass};then
				sed -i -e "/\$db_pass / s/ .*/ = '$newpass';/" 	$FoldConfCollabtive
				good " [ A ] $msqlCollabtiveUser new pass is $newpass"
			else
				err " [ A ] an error occurred"
			fi
		else
			warn " [ A ] cancelled by user"
		fi
	else
		warn " [ A ] skipped by user"
	fi
fi

#===[BONUS] PIWIK
if [ -n $FoldConfPiwik ];then
	title "Piwik passwords" "2"
	#get mysql infos
	getPiwikMysqlInfo $FoldConfPiwik
	# warn of action and ask if user is sure
	read -p " [ Q ] Type the user name you want to change password: " userName
	read -p " [ Q ] Type new password for user [$userName]: " newpass
	makeachoice "change [$userName] password for [$newpass]"
	if [ $? = 1 ]; then
		hashPass=$(echo -n "$newpass" | md5sum)
		hashPass=${hashPass//- } 	
		if updateMysqlPiwikUserName $userName $hashPass;then
			good " [ A ] $userName new pass is $newpass"
		else
			err " [ A ] an error occurred"
		fi
	else
		warn " [ A ] cancelled by user"
	fi

	# warn of action and ask if user is sure
	makeachoice "change Piwik database [$msqlPiwikDB] password for user [$msqlPiwikUser]"
	if [ $? = 1 ]; then
		read -p " [ Q ] Type new password for user [$msqlPiwikUser]: " newpass
		makeachoice "change [$msqlPiwikUser] password for [$newpass]"
		if [ $? = 1 ]; then
			if changeMysqlUserPass ${msqlPiwikUser} $newpass $msqlPiwikUser $msqlPiwikPass; then
				sed -i -e "/\password / s/ .*/ = \"$newpass\";/" 	$FoldConfPiwik
				good " [ A ] $msqlPiwikUser new pass is $newpass"
			else
				err " [ A ] an error occurred"
			fi
		else
			warn " [ A ] cancelled by user"
		fi
	else
		warn " [ A ] skipped by user"	
	fi
fi
