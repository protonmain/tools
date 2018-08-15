@echo off
title frogchou vpn修复工具
mode con cols=66 lines=40
rem 验证是否是以管理员身份运行
set TempFile_Name=%SystemRoot%\System32\BatTestUACin_SysRt%Random%.batemp
( echo "BAT Test UAC in Temp" >%TempFile_Name% ) 1>nul 2>nul
if not exist %TempFile_Name% (
color 0c
echo.
echo.
echo 	错误：没有以管理员身份运行该工具。
echo 	      该工具将无法使用！
echo.
echo 	方法：
echo 	找到该工具，右击"以管理员身份运行"。
echo.
echo 	按任意键退出该工具..... & pause >nul
exit
)

color 0a

echo *****************************************************************
echo.
echo 	该工具用于修复windows 10 系统无法连接ipsec vpn的的问题。	
echo.
echo 	★注意！请使用管理员权限运行改工具！
echo.
echo 	工具将执行以下操作：
echo 	1、添加注册表项
echo 	2、开启必要服务
echo.
echo *****************************************************************
echo.
echo 按任意键开始修复......
pause >nul
cls
rem 开始添加注册表项目
echo 正在添加注册表项......
reg add HKLM\SYSTEM\CurrentControlSet\services\RasMan\Parameters /v ProhibitIpSec /t REG_DWORD /d 00000000 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 00000002 /f

echo 正在启动必要的服务......
sc config "IKEEXT" start= AUTO
sc config "PolicyAgent" start= AUTO
sc config "EventLog" start= AUTO
sc config "RasMan" start= AUTO
sc config "RemoteRegistry" start= AUTO
sc config "RemoteAccess" start= AUTO
net start IKEEXT
net start PolicyAgent
net start EventLog
net start RasMan
net start RemoteRegistry
net start RemoteAccess

echo 执行完毕，请查看运行过程中是否报错，根据情况考虑手动执行。
echo.
echo ******************************提示*******************************
echo 如果RemoteAccess服务没有启动成功，请在执行以下操作：
echo 在“计算机”-“管理”—“设备管理”-“网络适配器”
echo -禁用“WAN miniport(IPv6)”
echo 操作完成后重新运行该工具。
echo *****************************************************************
echo.
echo.
echo.
echo 需要重新计算机，使配置生效。
:rebootquestion
set /p var=重启计算机吗？[Y/N]:
if "%var%"=="Y" goto reboot
if "%var%"=="y" goto reboot
if "%var%"=="N" goto end
if "%var%"=="n" (goto end) else (goto error)

:reboot
shutdown -r -t 0
exit

:end
echo 谢谢使用，按任意键退出。
pause >nul
exit

:error
echo 选择错误，请重新选择。
goto rebootquestion






