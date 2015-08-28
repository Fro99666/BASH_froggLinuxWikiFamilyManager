# TESTS
# =====
title "Preparing script...Testing pre-set" "0"

#-- check required commands
for req in ${requires[*]};do
	canExec req
	if [ $? = 0 ];then
		err "command ${req} is required for this script";((errFound++))
	fi
done

if [ $doMYUP = 1 -o $doWIBK = 1 -o $doWIUP = 1 -o $doPASS = 1 ];then
	#-- check required/option file/folder/url
	allCheck=("Fold" "File" "Url")
	allType=("Req" "Opt")
	for chr in ${allCheck[*]};do
		for typ in ${allType[*]};do
			#get required var list
			#allTest=$(compgen -v | grep "${chr}${typ}") #<don't works ??
			#allTest=${!FoldReq*} #<not dynamic
			eval "allTest=\${!${chr}${typ}*}"
			allTest=($allTest)
			#check required folders
			for res in ${allTest[*]};do
				#Depending of elment type
				case ${chr} in
					"Fold")exist "d" "${!res}";;
					"File")exist "f" "${!res}";;
					"Url")urlExist "${!res}";;
				esac
				#if not found create error
				if [ $? = 0 ]; then
					if [ $typ = "Req" ];then
						err "${!res} not found";((errFound++))
					else
						warn "${!res} not found"
					fi
				fi
			done
		done
	done
	#-- check & get wiki mysql conf
	exist "f" "$FileReqDbConf"
	if [ $? = 1 ];then
		#get database infos
		getWikiMysqlInfo ${FileReqDbConf}
		#then test database type
		if [ ! $msqlWikiType = "mysql" ];then
			err "Mediawiki database is ${msqlWikiType} and this script require Mysql database";((errFound++))		
		fi
	else
		if [ $doWIBK = 1 ];then
			err "Mediawiki database file infos ${FileReqDbConf} not found";((errFound++))
		fi
	fi
fi

#check result
echo -e "\n*******************************"
echo -e "# ${SCN}"
echo -e "# ${SCD}"
echo -e "# v${SCV} ${SCU}, Powered By ${SCA} - ${SCM} - Copyright ${SCY}"
echo -e "# Tested on       : ${SCT}"
echo -e "# script call     : ${SCC}"
echo -e "# Script's Options  :"
echo -e "# To auto confirm : ${SCC} -confirm"
echo -e "# Wiki's Options  :"
echo -e "# To Install      : ${SCC} -install"
echo -e "# To Update       : ${SCC} -update (will do a backup before)"
echo -e "# To Roll-back    : ${SCC} -rollback"
echo -e "# To Back Up      : ${SCC} -backup"
echo -e "# To do sitemap   : ${SCC} -sitemap"
echo -e "# To do htaccess  : ${SCC} -htaccess"
echo -e "# MySql's Options :"
echo -e "# MySql update    : ${SCC} -mysqlupdate (will do a backup before)"
echo -e "# MySql Roll-back : ${SCC} -mysqlrollback"
echo -e "# Addon's Options :"
echo -e "# Addon update    : ${SCC} -addonupdate (will do a backup before)"
echo -e "# Addon Roll-back : ${SCC} -addonrollback"
echo -e "# Linux Options   :"
echo -e "# Change Passwords: ${SCC} -changepass"
if [ $errFound -gt 0 ]; then
	err  "Errors has been found, script cannot continue..."
	echo "please solve errors before restart the script"
	echo -e "*************ABORTED***********\n"
	exit 1
else
	# Script begin
	echo -e "*******************************\n"
fi
