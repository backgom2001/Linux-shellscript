#!/bin/bash

. function.sh

TMP1=SCRIPTNAME.log
> $TMP1

BAR
CODE [U-46] 패스워드 최소 길이 설정
cat << EOF >> $RESULT
[양호]: 암호의 최소 길이가 8글자 이상
[취약]: 암호의 최소 길이가 7글자 미만
EOF
BAR

LOGINDEFFILE=/etc/login.defs

RET=$(grep PASS_MIN_LEN $LOGINDEFFILE | egrep -v '^$|^#' | awk '{print $2}')
if [ $RET -ge 8 ] ; then
        OK 암호정책 중 암호의 최소길이가 8글자 이상입니다.
else
        WARN 암호정책 중 암호의 최소길이가 7글자 미만입니다.
fi
INFO PASS_MIN_LEN $RET

cat $RESULT
echo; echo
