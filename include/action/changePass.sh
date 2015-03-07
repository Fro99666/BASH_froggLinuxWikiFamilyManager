# ========= PASSWORD
title "choose and change admin's users password (Linux,Wiki,Piwik,Collabtive)"

#===LINUX

# warn of action and ask if user is sure
if makeachoice "change password for Linux [$linuxRootUsr] user"; then
	passwd $linuxRootUsr
	#Method 0
	#passwd $sa
	#Method 1
	#openssl passwd -1 -salt xyz  yourpass
	#Method 2
	#makepasswd --clearfrom=- --crypt-md5 <<< YourPass
	#Method 3
	#echo -e "md5crypt\npassword" | grub | grep -o "\$1.*"		
fi

#===WIKI

# warn of action and ask if user is sure
if makeachoice "change Wiki database [$msqlWikiDb] password for user [$msqlWikiDbUsr]"; then
	read -p " [ Q ] Type new password for user [$msqlWikiDbUsr]: " newpass
	if makeachoice "continue"; then
		changeMysqlUserPass ${msqlWikiDbUsr} $newpass
		sed -i -e "/\$wgDBpassword / s/ .*/ = \"$newpass\";/" 	$FileReqDbConf
		good " [ A ] $msqlWikiDbUsr new pass is $newpass"
	else
		warn " [ A ] cancelled by user"			
	fi
fi

# warn of action and ask if user is sure
userName=getMysqlWikiUserName()
if makeachoice "change password for [$userName] Wiki user login"; then
	read -p " [ Q ] Type new password for user [$msqlWikiDbUsr]: " newpass
	if makeachoice "continue"; then
		php $FoldReqCommon/fr/changePassword.php --user=$userName --password=$newpass
		good " [ A ] $userName new pass is $newpass"
	else
		warn " [ A ] cancelled by user"
	fi
fi


#===TODO

#	err "AT WORK"
#fi

# Create root if not exist
# --- piwik
# --- collabtive		

# --- mysql
#echo " [ I ] creation, permission, set password for $sa in mysql"
# remove admin user if exist in mysql
#mysql -e "DELETE FROM user WHERE User='$sa'" -u root -p$mysqlRootPw mysql
# create properly the new mysql admin account
#mysql -e "CREATE USER '$sa'@'localhost' IDENTIFIED BY '$pw';GRANT USAGE ON *.* TO $sa@localhost IDENTIFIED BY '$pw';FLUSH PRIVILEGES;" -u root -p$mysqlRootPw mysql

# ===> BUG CREATE USER COMMAND DID NOT WORKED

# --- redmine
#echo " [ I ] permission, set password for $sa in redmine"
# database.yml (restore database connection) pour activer ca il faut add change use database dans mysql
#echo -e "production:\n adapter: mysql2\n database: redmine\n host: localhost\n username: redmine\n password: redmine" > /etc/redmine/default/database.yml #$redSrcPath/default/database.yml
# TODO : email.yml ( to set better)
#echo -e "production:\n  delivery_method: :smtp\n  smtp_settings:\n    address: smtp.iscope.fr\n    port: 25\n    domain: iscope.fr\n    authentication: :login\n    user_name: \"$em\"\n    password: \"xxxxxx\"" > $redSrcPath/config/email.yml
# create password hash
#pwHash=$( echo -n $pw | openssl sha1 )
# connect to database then do the request create sql request update redmine admin user's paswword
#mysql -e "UPDATE users SET hashed_password='$pwHash' WHERE login='$sa'" -u root -p$mysqlRootPw redmine

# --- wiki
#echo " [ I ] permission, set password for $sa in wiki"
# ajouter le wiki modify LocalSettings.php set user admin and pass test in config file
#sed -i -e "/\$wgDBuser / s/ .*/ = \"$sa\";/" 		$rootDir/$wikiDir/LocalSettings.php
#sed -i -e "/\$wgDBpassword / s/ .*/ = \"$pw\";/" 	$rootDir/$wikiDir/LocalSettings.php

# --- Display result
