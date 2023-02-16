#!/bin/bash

. function.sh
TMP1=`SCRIPTNAME`.log

> $TMP1


BAR

CODE [U-38] 웹서비스 불필요한 파일 제거
cat << EOF >> $RESULT
[양호]: r 계열 서비스가 비활성화 되어 있는 경우
[취약]: r 계열 서비스가 활성화 되어 있는 경우
EOF

BAR


TMP2=/tmp/tmp2

ls -1 /etc/xinetd.d | egrep '(rsh|rlogin|rexec)' > $TMP2

if [ -s $TMP2 ] ; then

WARN 'rCMD(rlogin,rsh,rcp) 서비스가 존재합니다.'

for i in `cat $TMP2`

do

RES=`cat /etc/xinetd.d/$i | egrep -v '^#' \

| egrep disable \

| awk '{print $3}'`

if [ $RES = 'yes' ] ; then

OK $i 서비스가 활성화 되어 있지 않습니다.

else

WARN $i 서비스가 활성화 되어 있습니다.

fi

done

else

OK 'rCMD(rlogin,rsh,rcp) 서비스가 존재하지 않습니다.'

fi

cat $RESULT

echo ; echo
