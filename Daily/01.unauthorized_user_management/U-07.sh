#!/bin/bash

. function.sh

BAR
CODE [U-07] /etc/passwd 파일 소유자 및 권한 설정
cat << EOF >> $RESULT
[양호]:  /etc/passwd 파일의 소유자가 root이고, 권한이 644 이하인 경우
[취약]:  /etc/passwd 파일의 소유자가 root가 아니거나, 권한이 644 이하가 아닌 경우
EOF
BAR

CHECK=0
ls /etc/passwd > /dev/null 2>&1
if [ $? = 0 ] ; then
        CHECK=1
fi

if [ $CHECK != 0 ] ; then
        CHOWN1=`ls -l /etc/passwd | awk '{print $3}'`
        if [ $CHOWN1 = root ] ; then
                OK /etc/passwd 파일이 존재하며 소유자는 root입니다.
        else
                WARN /etc/passwd 파일이 존재하지만 소유자는 root가 아닙니다.
        fi
elif [ $CHECK = 0 ] ; then
        INFO /etc/passwd 파일이 존재하지 않습니다.
fi

if [ $CHECK = 1 ] ; then
        find /etc/passwd -type f -perm -644 -ls | grep -v 'rw-r--r--' >/dev/null 2>&1
        if [ $? = 0 ] ; then
                WARN passwd 파일의 권한이 `ls -l /etc/passwd | awk '{print $1}'`로 설정되어 644보다 높습니다.
        else
                OK passwd 파일의 권한이 644이하 입니다.
        fi
fi

cat $RESULT

