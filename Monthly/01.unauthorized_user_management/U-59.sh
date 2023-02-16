#!/bin/bash

. function.sh 

BAR
CODE [U-59] 숨겨진 파일 및 디렉터리 검색 및 제거
cat << EOF >> $RESULT
[양호]: 디렉터리 내 숨겨진 파일을 확인하여, 불필요한 파일 삭제를 완료한 경우
[취약]: 디렉터리 내 숨겨진 파일을 확인하지 않고, 불필요한 파일을 방치한 경우
EOF
BAR

# 파일 및 디렉터리 파일 점검 
find / -type f -name '.*'>> U-59_FILE.txt
find / -type d -name '.*'>> U-59_DIR.txt
INFO U_59_FILE.txt, U-59_DIR.txt 파일을 확인해야합니다.
 

cat $RESULT
echo;
