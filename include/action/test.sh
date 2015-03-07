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

if [ $doMYUP = 1 -o $doWIBK = 1 -o $doWIUP = 1 ];then
	#-- check required/option file/folder/url
	allCheck=("Fold" "File" "Url")
	allType=("Req" "Opt")
	for chr in ${allCheck[*]};do
		for typ in ${allType[*]};do
			#get required var list
			#allTest=$(compgen -v | grep "${chr}${typ}") #<dont works ??
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
		getMysqlInfo ${FileReqDbConf}
		#then test database type
		if [ ! $msqlType = "mysql" ];then
			err "mediawiki database is ${msqlType} and this script require mysql database";((errFound++))		
		fi
		#mysql wiki database infos
		msqlWikiDb=$msqlDb			#wiki database name
		msqlWikiDbUsr=$msqlUser		#wiki database user name
		msqlWikiDbPss=$msqlPass		#wiki database pass
	else
		if [ $doWIBK = 1 ];then
			err "mediawiki database file infos ${FileReqDbConf} not found";((errFound++))
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
echo -e "# Wiki's Options  :"
echo -e "# To Install      : ${SCC} -install"
echo -e "# To Update       : ${SCC} -update (default option, will do a backup before)"
echo -e "# To Rollback     : ${SCC} -rollback"
echo -e "# To Back Up      : ${SCC} -backup"
echo -e "# MySql's Options :"
echo -e "# MySql update    : ${SCC} -mysqlupdate (will do a backup before)"
echo -e "# MySql Rollback  : ${SCC} -mysqlrollback"
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
