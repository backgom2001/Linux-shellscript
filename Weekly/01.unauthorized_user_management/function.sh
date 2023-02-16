LOG=check.log
RESULT=result.log
> $LOG
> $RESULT

BAR() {
echo "========================================================================" >> $RESULT
}

NOTICE() {
echo '[ OK ] : 정상'
echo '[WARN] : 비정상'
echo '[INFO] : Information 파일을 보고, 고객과 상의'
}

OK() {
echo -e '\033[1;33m'"[ 양호 ] : $*"'\033[0m'
} >> $RESULT
WARN() {
echo -e '\033[31m'"[ 경고 ] : $*"'\033[0m'
} >> $RESULT
INFO() { 
echo -e '\033[32m'"[ 정보 ] : $*"'\033[0m'
} >> $RESULT
CODE(){
echo -e '\033[36m'$*'\033[0m' 
} >> $RESULT

SCRIPTNAME() {
basename $0 | awk -F. '{print $1}'
}

VULN(){
echo -e '\033[31m'"[ 경고 ] : $*"'\033[0m'
} >> $RESULT
 
BLANKLINE(){
echo -e ''
} >> $RESULT
 
MAKE_LOGFILE(){
FILENAME=$(basename $(echo $0) | awk -F. '{print $1}').log
> "$FILENAME"
echo "$FILENAME"
}

FindPatternReturnValue() {
# $1 : File name
# $2 : Find Pattern
if egrep -v '^#|^$' $1 | grep -q $2 ; then # -q = 출력 내용 없도록
   ReturnValue=$(egrep -v '^#|^$' $1 | grep $2 | awk -F= '{print $2}')
else
   ReturnValue=None
fi
echo $ReturnValue
}

SearchValue() {
# $1 : VALUE or KEYVALUE
# $2 : specified file
# $3 : the word you want to find
# VALUE :
# KEYVALUE :

SEARCH=$(egrep -v '^#|^$' $2 | sed 's/#.*//' | grep -w $3)
if [ -z "$SEARCH" ] ; then
   echo FALSE
else
   if [ $1 = 'KEYVALUE' ] ; then
   echo $SEARCH
elif [ $1 = 'VALUE' ] ; then
   echo "$SEARCH" | awk '{print $2}'
   fi
fi
}
