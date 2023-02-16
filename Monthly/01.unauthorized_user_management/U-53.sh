#!/bin/bash

. function.sh

TMP1=SCRIPTNAME.log
> $TMP1
TMP2=/tmp/tmp1
TMP3=/tmp/tmp2
>$TMP3

BAR
CODE [U-53] 사용자 shell 점검
cat << EOF >> $RESULT
[취약]: 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되어 >있는 경우
[양호]: 로그인이 필요하지 않은 계정에 /bin/false(nologin) 쉘이 부여되지 >않은 경우
EOF
BAR
PASSFILE=/etc/passwd

awk -F: '$3 < 200 || $3 > 60000 {print $0}' $PASSFILE | grep -v '^root:' | \
egrep '(/bin/bash$|/bin/sh$|/bin/ksh$|/bin/csh$)' > $TMP2

if [ -s $TMP2 ] ; then
        WARN 로그인이 필요하지 않은 계정에 쉘이 부여 되었습니다.
        INFO $TMP1 파일을 참조 하세요
        cat << EOF >> $TMP1
===========================================================
1.다음 같은 조건을 가진, 로그인 가능 쉘이 부여된 사용자 목록입니다.
* UID 번호가 1 ~ 299 사용자 중 로그인 가능 쉘이 부여된 사용자
* UID 번호가 60001 ~ 65535 사용자 중 로그인 가능 쉘이 부여된 사용자

$(awk -F: '{print $1,   ":", $7}' $TMP2)
===========================================================
EOF
else
        OK 로그인이 필요하지 않은 계정에 쉘이 부여 되지 않았습니다.
fi

cat $RESULT
echo ; echo
