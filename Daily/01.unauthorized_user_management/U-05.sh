#!/bin/bash

. function.sh

BAR
CODE [U-05] root홈, 패스 디렉터리 권한 및 패스 설정
cat << EOF >> $RESULT
[양호]: PATH 환경변수에 “.” 이 맨 앞이나 중간에 포함되지 않은 경우
[취약]: PATH 환경변수에 “.” 이 맨 앞이나 중간에 포함되어 있는 경우
EOF
BAR

CHECK=$(echo $PATH | egrep "\.:|::|:.:" )

if [ -z $CHECK ] ; then
    OK "PATH 환경변수에 “.” 이 맨 앞이나 중간에 포함되지 않은 경우"
else
    VULN "PATH 환경변수에 “.” 이 맨 앞이나 중간에 포함되어 있는 경우"
fi

cat $RESULT
