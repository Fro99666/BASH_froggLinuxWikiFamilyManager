#installPhpExt {extName} {extAptGet}
installPhpExt()
{
touch tmpTest.php
echo -e "#!/usr/bin/php\n<?php\nif(!extension_loaded('${1}')){echo '0';}else{echo '1';}\n?>" >  tmpTest.php
tmpVal=$(php tmpTest.php)
rm tmpTest.php
if [ $tmpVal = 0 ];then
	#if not installed ask user to install it
	makeachoice "install [${1}] PHP extension"
	if [ $? = 1 ];then
		#si error faire un "apt-get update" avant
		apt-get install ${2}
		service apache2 restart
	fi
else
	good "PHP Extension ${1} already installed"
fi
}