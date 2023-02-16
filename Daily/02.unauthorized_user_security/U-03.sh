#!/bin/bash

. function.sh

TMP1=`SCRIPTNAME`.log
> $TMP1

 
BAR
CODE [U-03] 계정 잠금 임계값 설정
cat << EOF >> $RESULT
[양호]: 계정 잠금 임계값이 5 이하의 값으로 설정되어 있는 경우
[취약]: 취약: 계정 잠금 임계값이 설정되어 있지 않거나, 5 이하의 값으로 설정되지 않은 경우
EOF
BAR

FILE1=/etc/pam.d/system-auth
PAM_MODULE=pam_tally.so
LINE1=`cat $FILE1 | egrep -v '(^#|^$)' | grep '^auth' | grep $PAM_MODULE`
if [ $? -ne 0 ] ; then
WARN 계정 임계값이 설정되어 있지 않습니다.
else
OK 계정 임계값이 설정되어 있습니다.
LINE2=`echo $LINE1 | cut -d ' ' -f 4-`
for VAR in `echo $LINE2`
do

CHECK1=`echo $VAR | awk -F= '{print $1}'`
CHECK2=`echo $VAR | awk -F= '{print $2}'`
case $CHECK1 in
deny) if [ $CHECK2 -lt 5 ] ; then

OK 계정임계값이 5이하로 설정되어 있습니다.
else
WARN 계정임계값이 5초과하여 설정되어 있습니다.
fi ;;
*) ;;
esac
done
fi
cat $RESULT
echo ""
