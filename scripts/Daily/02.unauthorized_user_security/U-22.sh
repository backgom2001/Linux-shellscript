#!/bin/bash

. function.sh
TMP1=SCRIPTNAME.log
> $TMP1

BAR
CODE '[U-22] cron 파일 소유자 및 권한 설정'
cat << EOF >> $RESULT
[양호]: cron 접근제어 파일 소유자가 root이고, 권한이 640 이하인 경우
[취약]: cron 접근제어 파일 소유자가 root가 아니거나, 권한이 640 이하가 아닌 경우
EOF
BAR

PERMLIST=/scripts/cron
cat $PERMLIST | while read FILE1 USER PERM1 PERM2
do
        if [ -f /etc/$FILE1 ] ; then
                INFO "[+] $FILE1이 존재 합니다."
                RET=$(find /etc -name $FILE1 -user $USER -perm -$PERM1 -ls | grep -v $PERM2)
                if [ -z "$RET" ] ; then
                        OK $FILE1 소유자가 root 사용자이며, 퍼미션이 640 이하입니>다.
                else
                        WARN $FILE1 소유자가 root 사용자가 아니거나, 퍼미션이 640 초과입니다.
                        INFO $TMP1 파일을 참고하십시오.
                        cat << EOF >> $TMP1
===========================================================
1.  다음은 cron 사용자 제어용 파일의 속성 정보입니다.
$(echo $RET)
===========================================================
EOF
                fi
        else
                INFO "[-] $FILE1이 존재하지 않습니다."
        fi
done

cat $RESULT
echo ; echo
