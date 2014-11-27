getMysqlInfo()
{
tmpCat=$(cat ${1})
msqlType=`echo "$tmpCat" | grep "wgDBtype" | cut -d \" -f 2`
msqlDb=`echo "$tmpCat" | grep "wgDBname" | cut -d \" -f 2`
msqlUser=`echo "$tmpCat" | grep "wgDBuser" | cut -d \" -f 2`
msqlPass=`echo "$tmpCat" | grep "wgDBpassword" | cut -d \" -f 2`
tmpCat=""
}