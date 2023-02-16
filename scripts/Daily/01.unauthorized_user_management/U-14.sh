#!/bin/bash

. function.sh

BAR
CODE '[U-14] : 사용자, 시스템 시작파일 및 환경파일 소유자 및 권한 설정'
cat << EOF >> $RESULT
[양호]: 홈 디렉터리 환경변수 파일 소유자가 root 또는, 해당 계정으로 지정되어 있고, 홈 디렉터리 환경변수 파일에 root와 소유자만 쓰기 권한이 부여된 경우
[취약]: 홈 디렉터리 환경변수 파일 소유자가 root 또는, 해당 계정으로 지정되지 않고, 홈 디렉터리 환경변수 파일에 root와 소유자 외에 쓰기 권한이 부여된 경우
EOF
BAR

FILENAME1="/etc/profile"
FILENAME2=".bashrc"
FILENAME3=".bash_profile"

INFO "사용자 별 환경변수 파일의 권한 및 소유자를 확인하세요"
ls -l $FILENAME1 | awk '{print $9, $1, $3, $4}' >> $RESULT
ls -l ~/$FILENAME2 | awk '{print $9, $1, $3, $4}' >> $RESULT
ls -l ~/$FILENAME3 | awk '{print $9, $1, $3, $4}' >> $RESULT

cat $RESULT
echo ""
