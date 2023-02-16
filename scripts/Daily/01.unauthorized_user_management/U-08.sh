#!/bin/bash

. function.sh

TMP1=SCRIPTNAME.log
> $TMP1

TARGET='shadow'
BAR
CODE '[U-08] /etc/shadow 파일 소유자 및 권한 설정'
cat << EOF >> $RESULT
[양호]: /etc/$TARGET 파일의 소유자가 root이고, 권한이 400인 경우
[취약]: /etc/$TARGET 파일의 소유자가 root가 아니거나, 권한이 400이 아닌 경우
EOF
BAR

PERMLIST=/etc/shadow
TARGETLINE=$(grep $TARGET $PERMLIST)

if [ -f /etc/$TARGET ] ; then
        INFO "[+] /etc/$TARGET이 존재 합니다."
        echo $TARGETLINE | while read FILE1 USER PERM1 PERM2
        do
                RET=$(ls -l $PERMLIST | awk '{print $3}')
                echo $RET
                if [ -z "$RET" ] ; then
                                OK $FILE1 소유자가 root 사용자이며, 퍼미션이 400입니다.
                else
                                WARN $FILE1 소유자가 root 사용자가 아니거나, 퍼미션이 400이 아닙니다.
                                INFO $TMP1 파일을 참고하십시오.
                                cat << EOF >> $TMP1
===========================================================
1.  다음은 /etc/$TARGET 파일의 속성 정보입니다.
$(echo $RET)
===========================================================
EOF
                fi
        done
else
        INFO "[-] /etc/$TARGET이 존재 하지 않습니다."
fi

cat $RESULT
