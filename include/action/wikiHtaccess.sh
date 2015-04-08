#ask user for edit script config
makeachoice "generate Mediawiki .htaccess"
if [ $? = 0 ]; then
	warn "exit script, cancelled by user"
	exit
fi

title "Create each .htaccess" "1"

# Doing stuff for each lang
# -------------------------
for lang in ${FoldReqWiki}*;do

	if [ ! "${lang}/" = $FoldReqCommon -a -d $lang ];then
	
		#just the folder name
		shortLang=${lang##*/}
		title "Generate .htaccess ${shortLang}" "2"
		
		cd $lang
		
		#add robots.txt
		if [ ! -e ".htaccess" ];then
		
			cat <<EOF > .htaccess
# MOD_DEFLATE COMPRESSION
SetOutputFilter DEFLATE
AddOutputFilterByType DEFLATE text/html text/css text/plain text/xml application/x-javascript application/x-httpd-php

# DEFLATE NOT COMPATIBLE BROWERS
BrowserMatch ^Mozilla/4 gzip-only-text/html
BrowserMatch ^Mozilla/4\.0[678] no-gzip
BrowserMatch \bMSIE !no-gzip !gzip-only-text/html
BrowserMatch \bMSI[E] !no-gzip !gzip-only-text/html

# NOT CHACHING IF ALREADY CACHED
SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png)$ no-gzip

# PROXY CHECK CONTENT
Header append Vary User-Agent env=!dont-vary

# EXPIRE HEADERS
<IfModule mod_expires.c>
ExpiresActive On
#Images
ExpiresByType image/jpg "access plus 1 year"
ExpiresByType image/jpeg "access plus 1 year"
ExpiresByType image/gif "access plus 1 year"
ExpiresByType image/png "access plus 1 year"
AddType image/x-icon .ico
ExpiresByType image/ico "access plus 1 year"
ExpiresByType image/icon "access plus 1 year"
ExpiresByType image/x-icon "access plus 1 year"
#Elements
ExpiresByType application/xhtml+xml "access plus 1 week"
ExpiresByType text/html "access plus 1 week"
ExpiresByType text/css "access plus 1 week"
ExpiresByType application/javascript "access plus 1 week"
ExpiresByType text/x-javascript "access plus 1 week"
#Others
ExpiresDefault "access plus 1 month"
</IfModule>

# CACHE-CONTROL HEADERS
<IfModule mod_headers.c>
<FilesMatch "\\.(ico|jpe?g|png|gif|swf|gz|ttf)$">
Header set Cache-Control "max-age=2797200, public"
</FilesMatch>
<FilesMatch "\\.(css)$">
Header set Cache-Control "max-age=2797200, public"
</FilesMatch>
<FilesMatch "\\.(js)$">
Header set Cache-Control "max-age=2797200, private"
</FilesMatch>
<filesMatch "\\.(html|htm)$">
Header set Cache-Control "max-age=86400, public"
</filesMatch>
# Disable caching for scripts and other dynamic files
<FilesMatch "\.(pl|php|cgi|spl|scgi|fcgi)$">
Header unset Cache-Control
</FilesMatch>
</IfModule>

# KILL THEM ETAGS
Header unset ETag
FileETag none

# PROTECT .HTACCESS
<files .htaccess>
order allow,deny
deny from all
</files>

# PROTECT FOLDER READING
Options -Indexes
EOF
		else
			warn ".htaccess not created: already exist"
		fi
	fi
done
