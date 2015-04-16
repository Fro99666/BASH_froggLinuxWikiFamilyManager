#MYSQL
changeMysqlUserPass()
{
echo $(mysql -u${3} -p${4} -e "SET PASSWORD FOR '$1'@'localhost' = PASSWORD('$2');")
}

#WIKI
getWikiMysqlInfo()
{
tmpCat=$(cat ${1})
msqlWikiType=`echo "$tmpCat" | grep "wgDBtype" | cut -d \" -f 2`
msqlWikiDb=`echo "$tmpCat" | grep "wgDBname" | cut -d \" -f 2`
msqlWikiUser=`echo "$tmpCat" | grep "wgDBuser" | cut -d \" -f 2`
msqlWikiPass=`echo "$tmpCat" | grep "wgDBpassword" | cut -d \" -f 2`
tmpCat=""
}
msqlType
msqlDb
msqlUser
msqlPass

getMysqlWikiUserName()
{
#get wiki web folder
tmpCat=$(cat ${FileReqDbConf})
shareDbPrefix=`echo "$tmpCat" | grep "shareDbPrefix" | cut -d \" -f 2`
cmdRes=$(mysql -u$msqlWikiUser -p$msqlWikiPass -e "SELECT user_name FROM ${msqlWikiDb}.${shareDbPrefix}user where user_id=1;")
echo ${cmdRes//user_name} | tr -d '\n'
}

#COLLABTIVE
getCollabtiveMysqlInfo()
{
tmpCat=$(cat ${1})
msqlCollabtiveDb=`echo "$tmpCat" | grep "db_name" | cut -d \' -f 2`
msqlCollabtiveUser=`echo "$tmpCat" | grep "db_user" | cut -d \' -f 2`
msqlCollabtivePass=`echo "$tmpCat" | grep "db_pass" | cut -d \' -f 2`
tmpCat=""
}

getMysqlCollabtiveUserName()
{
cmdRes=$(mysql -u$msqlCollabtiveUser -p$msqlCollabtivePass -e "SELECT name FROM ${msqlCollabtiveDb}.user where id=1;")
echo ${cmdRes//name} | tr -d '\n'
}

updateMysqlCollabtiveUserName()
{
echo $(mysql -u$msqlCollabtiveUser -p$msqlCollabtivePass -e "UPDATE ${msqlCollabtiveDb}.user SET pass='${2}' where name='${1}'")
}

#PIWIK
getPiwikMysqlInfo()
{
tmpCat=$(cat ${1})
msqlPiwikUser=`echo "$tmpCat" | grep "username" | cut -d \" -f 2`
msqlPiwikPass=`echo "$tmpCat" | grep "password" | cut -d \" -f 2`
msqlPiwikDB=`echo "$tmpCat" | grep "dbname" | cut -d \" -f 2`
msqlPiwikTable=`echo "$tmpCat" | grep "tables_prefix" | cut -d \" -f 2`
tmpCat=""
}

updateMysqlPiwikUserName()
{
echo $(mysql -u$msqlPiwikUser -p$msqlPiwikPass -e "UPDATE ${msqlPiwikDB}.${msqlPiwikTable}user SET password = '${2}', token_auth = '${2}' WHERE login = '${1}'")
}