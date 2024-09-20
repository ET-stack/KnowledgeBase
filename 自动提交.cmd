@echo off
:: 切换到脚本所在目录
cd /d %~dp0

:: 显示正在添加的文件
echo 正在添加文件...
git add *

:: 显示提交信息
echo 正在提交...
git commit -m "自动提交"

:: 显示推送信息
echo 正在推送到远程仓库...
git push

:: 操作完成提示
echo 提交并推送完成！
pause
