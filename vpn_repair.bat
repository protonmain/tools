@echo off
title frogchou vpn�޸�����
mode con cols=66 lines=40
rem ��֤�Ƿ����Թ���Ա�������
set TempFile_Name=%SystemRoot%\System32\BatTestUACin_SysRt%Random%.batemp
( echo "BAT Test UAC in Temp" >%TempFile_Name% ) 1>nul 2>nul
if not exist %TempFile_Name% (
color 0c
echo.
echo.
echo 	����û���Թ���Ա������иù��ߡ�
echo 	      �ù��߽��޷�ʹ�ã�
echo.
echo 	������
echo 	�ҵ��ù��ߣ��һ�"�Թ���Ա�������"��
echo.
echo 	��������˳��ù���..... & pause >nul
exit
)

color 0a

echo *****************************************************************
echo.
echo 	�ù��������޸�windows 10 ϵͳ�޷�����ipsec vpn�ĵ����⡣	
echo.
echo 	��ע�⣡��ʹ�ù���ԱȨ�����иĹ��ߣ�
echo.
echo 	���߽�ִ�����²�����
echo 	1�����ע�����
echo 	2��������Ҫ����
echo.
echo *****************************************************************
echo.
echo ���������ʼ�޸�......
pause >nul
cls
rem ��ʼ���ע�����Ŀ
echo �������ע�����......
reg add HKLM\SYSTEM\CurrentControlSet\services\RasMan\Parameters /v ProhibitIpSec /t REG_DWORD /d 00000000 /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\PolicyAgent /v AssumeUDPEncapsulationContextOnSendRule /t REG_DWORD /d 00000002 /f

echo ����������Ҫ�ķ���......
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

echo ִ����ϣ���鿴���й������Ƿ񱨴�������������ֶ�ִ�С�
echo.
echo ******************************��ʾ*******************************
echo ���RemoteAccess����û�������ɹ�������ִ�����²�����
echo �ڡ��������-�����������豸����-��������������
echo -���á�WAN miniport(IPv6)��
echo ������ɺ��������иù��ߡ�
echo *****************************************************************
echo.
echo.
echo.
echo ��Ҫ���¼������ʹ������Ч��
:rebootquestion
set /p var=�����������[Y/N]:
if "%var%"=="Y" goto reboot
if "%var%"=="y" goto reboot
if "%var%"=="N" goto end
if "%var%"=="n" (goto end) else (goto error)

:reboot
shutdown -r -t 0
exit

:end
echo ллʹ�ã���������˳���
pause >nul
exit

:error
echo ѡ�����������ѡ��
goto rebootquestion






