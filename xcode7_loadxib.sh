#/bin/bash
# Author: 376811578@qq.com
# Function:
#   Xcode8打开的Xib文件会加上一个最低xcode8才能打开的capability,这个脚本用于一键将xib中的capability限制删除掉，可以使xcode7也能打开xcode8编辑过的xib文件
basePath=$1
if [ $# -ne 1 ];then
	#如果没有一个参数
	echo "请输入要修改的项目地址,以'/'结尾!!!"
    exit;
fi
#删除源文件
rm -rf ~/Desktop/xcode7.txt
#获取xib文件列表
sudo find $basePath -type f -name *.xib -print > ~/Desktop/xcode7.txt
#删除xib文件中的指定字符串
cat ~/Desktop/xcode7.txt | while read line;
do
echo $line;
#删除带有xcode8限制的一行
sed '/documents saved in the Xcode 8 format/d' $line > $line.bak && mv -f $line.bak $line
done
