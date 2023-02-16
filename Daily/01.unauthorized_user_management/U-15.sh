#!/bin/bash

. function.sh

TMP1=`SCRIPTNAME`.log
> $TMP1
TMP2=/tmp/tmp1
BAR
CODE [U-15] Session Timeout 설정
cat << EOF >> $RESULT
[양호]: Session Timeout이 600초(10분) 이하로 설정되어 있는 경우
[취약]: Session Timeout이 600초(10분) 이하로 설정되지 않은 경우
EOF
BAR

PASSFILE=/etc/passwd
 
TMOUT_USER=$(awk -F: '$3 >= 1000 && $3 < 60000 {print $1}' $PASSFILE | head -1)
TMOUT_OUTPUT=$($TMOUT_USER -c 'echo $TMOUT')
if [ -z $TMOUT_OUTPUT ] ; then
WARN 세션 타임아웃 설정이 되어 있지 않습니다.
else
INFO 세션 타임아웃 설정이 되어 있습니다.
if [ $TMOUT_OUTPUT -le 600 ] ; then
OK "세션 타임아웃이 600초(10분) 이하로 설정되어 있습니다."
else
WARN "세션 타임아웃이 600초(10분) 이하로 설정되지 않았습니다."
fi
INFO $TMP1 파일을 참고 하십시오.

echo "========================================================" >> $TMP1

echo "1. 무작위로 선출된 사용자 $TMOUT_USER의 TMOUT 변수 설정 확인" >> $TMP1

echo "" >> $TMP1
echo "$TMOUT_USER's \$TMOUT = $TMOUT_OUTPUT" >> $TMP1
echo "========================================================" >> $TMP1
fi
cat $RESULT
echo ; echo
