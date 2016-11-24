%%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a 
cls
﻿%%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a 
cls
﻿%%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a %%a
@echo off
if defined converted goto :converted
color 0a
set ConverterPath=%temp%\HostsGeter_CodeConverter.vbs
set ConverterOutput=%temp%\HostsGeter_GBK.bat

echo inputpath="%~0" >%ConverterPath%
echo outputpath="%ConverterOutput%" >>%ConverterPath%
echo set stm2=createobject("ADODB.Stream") >>%ConverterPath%
echo stm2.Charset ="utf-8" >>%ConverterPath%
echo stm2.Open >>%ConverterPath%
echo stm2.LoadFromFile inputpath >>%ConverterPath%
echo readfile = stm2.ReadText >>%ConverterPath%
echo stm2.Close >>%ConverterPath%
echo Set Stm1 =CreateObject("ADODB.Stream") >>%ConverterPath%
echo Stm1.Type = 2 >>%ConverterPath%
echo Stm1.Open >>%ConverterPath%
echo Stm1.Charset ="GBK" >>%ConverterPath%
echo Stm1.Position = Stm1.Size >>%ConverterPath%
echo Stm1.WriteText "set converted=y" ^& vbcrlf >>%ConverterPath%
echo Stm1.WriteText readfile >>%ConverterPath%
echo Stm1.SaveToFile outputpath,2 >>%ConverterPath%
echo Stm1.Close >>%ConverterPath%
%ConverterPath% && %ConverterOutput%
goto :eof

:converted

chcp 936
:: 更改cmd窗口代码页至 936(GBK)

cls
%1 %2
ver|find " 5.">nul &&goto :st
echo 正在进行 UAC 提权...
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :st","","runas",1)(window.close)&goto :eof
:st

cls

@REM HostsGet 
cd /d %~dp0
color 0a
set LogFilePath=%temp%\HostsGeter_log.txt
set DLScriptPath=%temp%\downloadhosts.vbs
set DLPath=%windir%\system32\drivers\etc\hosts_downloaded
set BackupDir=%windir%\system32\drivers\etc
set HostsPath=%windir%\system32\drivers\etc\hosts

set LogToFile=^>^>%LogFilePath% 2^>^&1
set EchoAndLog=call :echoandlog
echo. %LogToFile%
echo ==========[%date% %time%]========== %LogToFile%
echo 日志文件：
echo %LogFilePath%
echo.

echo iLocal=LCase("%DLPath%") > %DLScriptPath% ||(
 call :error downloadhosts.vbs 文件创建/写入失败.
)
echo iRemote=LCase("https://raw.githubusercontent.com/WUZHIQIANGX/hosts/master/hosts") >> %DLScriptPath%
echo Set xPost=createObject("Microsoft.XMLHTTP") 'Set Post = CreateObject("Msxml2.XMLHTTP") >> %DLScriptPath%
echo xPost.Open "GET",iRemote,0 >> %DLScriptPath%
echo xPost.Send() >> %DLScriptPath%
echo set sGet=createObject("ADODB.Stream") >> %DLScriptPath%
echo sGet.Mode=3 >> %DLScriptPath%
echo sGet.Type=1 >> %DLScriptPath%
echo sGet.Open() >> %DLScriptPath%
echo sGet.Write xPost.ResponseBody >> %DLScriptPath%
echo sGet.SaveToFile iLocal,2 >> %DLScriptPath%
start http://idannywu.com/hosts/.html
start http://idannywu.com
%EchoAndLog% 开始从 GitHub 中下载 hosts 文件...
if exist %DLPath% del %DLPath% /s /q %LogToFile%
%DLScriptPath% || call :error hosts 文件下载失败.
del %DLScriptPath% /s /q %LogToFile%
if not exist %DLPath% call :error hosts 文件下载失败.
%EchoAndLog% 下载完成.
echo.
color 0a
if exist %HostsPath% (
    call :backuphosts
) else (
    %EchoAndLog% （原 hosts 文件不存在，跳过备份）
)
%EchoAndLog% 正在替换 hosts 文件...
move %DLPath% %HostsPath% %LogToFile% || call :error hosts 文件替换失败.
%EchoAndLog% hosts 文件已替换.
echo.

%EchoAndLog% 正在刷新系统 DNS 缓存...
ipconfig /flushdns %LogToFile% || call :error DNS 缓存刷新失败.
%EchoAndLog% DNS 缓存已刷新.
echo.
%EchoAndLog% 【志强恭喜你，操作全部完成！】
echo.

echo 请按任意键进行测试，如取消，请直接关闭本窗口
echo.
pause >nul
start https://www.google.com/ncr
start https://www.facebook.com
echo 志强已经帮你访问，如可以访问则替换成功。
echo 谢谢你的使用！
echo.
goto :end
color 0a
:backuphosts
%EchoAndLog% 正在备份原 hosts 文件...
set "bakfilename=hosts.bak"
set bakfilename=%bakfilename:/=-%
set bakfilename=%bakfilename:\=-%
set bakfilename=%bakfilename::=-%
set bakfilename=%bakfilename: =_%
copy %HostsPath% %BackupDir%\%bakfilename% %LogToFile% || call :error hosts 文件备份失败.
%EchoAndLog% 原 hosts 文件已备份到 %BackupDir%\%bakfilename%.
echo.
del /f /s /q C:\Windows\System32\drivers\etc\hosts.ics
del /f /s /q C:\Windows\System32\drivers\etc\hosts.bak
del /f /s /q C:\Windows\System32\drivers\etc\hosts.ics_new
del /f /s /q C:\Windows\System32\drivers\etc\hosts_backup
goto :eof
color 0a
:error
echo ======================
%EchoAndLog% 错误：%*
start %LogFilePath%
echo 已打开日志文件
goto :end

:echoandlog
echo %*
echo %* %LogToFile%
goto :eof
color 0a
:end
echo 请按任意键关闭
pause >nul
exit

