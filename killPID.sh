#/bin/bash
# Author: 376811578@qq.com
# Function:
#   杀掉当前关键词的进程(没做参数校验，因为就是为了满足不传参一键关掉所有进程，这样多好，不用每次关机还要出各种小意外了。。。)
KEY_WORD=$1
PIDPROC=`ps -ef | grep "${KEY_WORD}" | grep -v 'grep'| awk '{print $2}'`

if [ -z "$PIDPROC" ];then
echo "$KEY_WORD is not running"
exit 0
fi

echo "PIDPROC: "$PIDPROC
for PID in $PIDPROC
do
if kill -9 $PID
then echo "process $KEY_WORD (Pid:$PID) was force stopped at " `date`
fi
done
echo stop finished.
