#update wiki git folder
newaction "update mediawiki GIT in ${FoldOptWikiGit}" "Update/Install mediawiki GIT core"

# Get or Update core wiki
# -----------------------
title "Get or Update GIT" "2"
updateGit "${FoldOptWikiGit}" "${UrlReqWikiGit}"

#choose a version in git
chooseGitVersion ${FoldOptWikiGit}

# Install dependencies
# ---------------------
title "Install dependencies" "2"
doComposer $FoldOptWikiGit


