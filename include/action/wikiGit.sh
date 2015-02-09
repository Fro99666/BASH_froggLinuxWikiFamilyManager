#mysqlbackup
newaction "update mediawiki GIT in ${FoldOptWikiGit}" "Update/Install mediawiki GIT core"

# Get or Update core wiki
# -----------------------
title "Get or Update GIT" "2"
updateGit ${FoldOptWikiGit} ${UrlReqWikiGit}

# Install dependencies
# ---------------------
title "Install dependencies" "2"
cd $FoldOptWikiGit
curl -sS "$UrlReqComposer"| php
php composer.phar install

#choose a version in git
cd ${FoldOptWikiGit}
chooseGitVersion
