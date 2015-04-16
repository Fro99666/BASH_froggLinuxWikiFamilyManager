# Checking Configuration
# ----------------------
title "Checking server configuration" "1"
#Folder rights
title "Folder Rights" "2"
# set the right to Linux web user
chown "$linuxWebUsr" ${FoldReqWiki} -R
[ -f ${FoldReqWiki}${msqlWikiDb}.sql ] && rm ${FoldReqWiki}${msqlWikiDb}.sql
#Prevent > Warning: Your default directory for uploads /opt/wiki/{...}/images/ is vulnerable to arbitrary scripts execution.
mkdir -p ${FoldReqCommon}/images/
chmod 750 ${FoldReqCommon}/images/* -R
good "${FoldReqWiki} Rights updated"
#php extensions
title "PHP Extensions" "2"
# Prevent in wiki : Warning: The intl PECL extension is not available to handle Unicode normalization, falling back to slow pure-PHP implementation.
installPhpExt "intl" "php5-intl"
#Prevent > Warning: Could not find APC, XCache or WinCache.
installPhpExt "APC" "php-apc"

good "server configuration updated"
