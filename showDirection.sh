#/bin/bash
# Author: 376811578@qq.com
# Function:
# 	打开和关闭隐藏文件夹
echo "请输入以下序号:\n1.关闭隐藏文件\n2.打开隐藏文件"
read count

if [ $count == 1 ];
then
defaults write com.apple.finder AppleShowAllFiles false
killall Finder

elif [ $count == 2 ];
then
defaults write com.apple.finder AppleShowAllFiles true
killall Finder

else
echo "输入值非法!"
exit
fi
