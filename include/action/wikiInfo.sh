#Get Wiki infos
newaction "get Wiki Install information"

title "Prepare installation" "1"

title "Get languages informations" "2"

read -p " [ Q ] Type the language list you want to install separate with space (example:es fr en de): " usrLangList
if [ $usrLangList = "" ];then
	err "invalid capture, exit script"
	exit
fi
langList=( $usrLangList )

title "prepare folders ${FoldReqOrigin}" "2"
mkdir -p ${FoldReqOrigin}

title "prepare folders ${FoldReqGit}" "2"
mkdir -p ${FoldReqGit}

title "prepare folders ${FoldReqWiki}" "2"
mkdir -p ${FoldReqWiki}

title "prepare folders ${FoldReqCommon}" "2"
mkdir -p ${FoldReqCommon}

for lang in $langList;do
	title "prepare folders ${FoldReqWiki}${lang}" "2"
	mkdir -p ${FoldReqWiki}${lang}
done
