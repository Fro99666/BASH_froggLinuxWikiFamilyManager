#ask user for edit script config
makeachoice "Install Mediawiki ? Before start did you edited ${inc}config.sh with your infos"
if [ $? = 0 ]; then
	warn "exit script, cancelled by user"
	exit
fi

#set auto validation
doAUTO=1;

title "Prepare installation" "1"

title "Get languages informations" "2"

read -p " [ Q ] Type the language list you want to install separate with space (like:es fr en de): " usrLangList
if [ $usrLangList = "" ];then
	err "invalid capture, exit script"
	exit
fi

title "prepare folders ${FoldReqGit}" "2"
mkdir -p ${FoldReqGit}

title "prepare folders ${FoldReqWiki}" "2"
mkdir -p ${FoldReqWiki}

title "prepare folders ${FoldReqCommon}" "2"
mkdir -p ${FoldReqCommon}

IFS=" " read -ra langList <<< "$usrLangList"
for lang in ${langList[@]};do
	#check if 2 letters
	if [ ${#lang} = 2 ];then 
		title "prepare folders ${FoldReqWiki}${lang}" "2"
		mkdir -p ${FoldReqWiki}${lang}
	else
		err "[${lang}] is not a valid value, exit script"
		exit
	fi
done
