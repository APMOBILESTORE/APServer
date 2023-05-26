@shift /0
@echo off
color 3f
mode con:cols=95 lines=15
Console.exe apache\bin\httpd -k start
Console.exe php\php-cgi -b 127.0.0.1:9000
Console.exe mysql\bin\mysqld

QPROCESS * | find /I /N "httpd.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	SET apaches=Apache is running.
)else (
	SET apaches=Apache is not running.
)

QPROCESS * | find /I /N "php-cgi.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	SET phps=PHP is running.
)else (
	SET phps=PHP is not running.
)

QPROCESS * | find /I /N "mysqld.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	SET sqls=MYSQL is running.
)else (
	SET sqls=MYSQL is not running.
)

QPROCESS * | find /I /N "sip.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	SET sips=SIP is running.
)else (
	SET sips=SIP is not running.
)
QPROCESS * | find /I /N "icecast.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	SET ices=Icecast is running.
)else (
	SET ices=Icecast is not running.
)
title AP Server : Start
goto main
:main
cls
echo			AP Server 1.0 (Apache PHP MySql phpMyAdmin miniSIP Icecast )
echo	==============================================================================================
echo	 (1)Start Server	(2)Stop Server		(3)Restart Server	(4)Shutdown Server
echo	==============================================================================================
echo	 (5)Open Admin		(6)Open phpMyAdmin	(7)Open SIP Admin	(8)Open Icecast Admin
echo	==============================================================================================
echo	 (9)Creat Backup	(10)Restore Backup	(11)Clear Backup Log	(12)Reset Browser
echo	==============================================================================================
echo	 (13)Open Root		(14)About us		(15)Readme		(16)Run in Background
echo	==============================================================================================
echo	 Status: %apaches%	: %phps%	: %sqls% 
echo	----------------------------------------------------------------------------------------------
echo	 Status: %sips%	: %ices%
echo	----------------------------------------------------------------------------------------------
set /p choice= Enter Number:
cls
if %choice% == 1 goto label1
if %choice% == 2 goto label2
if %choice% == 3 goto label3
if %choice% == 4 goto label4
if %choice% == 5 goto label5
if %choice% == 6 goto label6
if %choice% == 7 goto label7
if %choice% == 8 goto label8
if %choice% == 9 goto label9
if %choice% == 10 goto label10
if %choice% == 11 goto label11
if %choice% == 12 goto label12
if %choice% == 13 goto label13
if %choice% == 14 goto label14
if %choice% == 15 goto label15
if %choice% == 16 goto label16


:label1
QPROCESS * | find /I /N "mysqld.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	echo MYSQL is already running.
)else (
	Console.exe mysql\bin\mysqld --console
	echo MYSQL is now running.
	SET sqls=MYSQL is running.
)

QPROCESS * | find /I /N "httpd.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	echo Apache is already running.
)else (
	Console.exe apache\bin\httpd -k start
	echo Apache is now running.
	SET apaches=Apache is running.
)

QPROCESS * | find /I /N "php-cgi.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	echo PHP is already running.
)else (
	Console.exe php\php-cgi -b 127.0.0.1:9000
	echo PHP is now running.
	SET phps=PHP is running.
)

QPROCESS * | find /I /N "sip.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	echo SIP is already running.
)else (
	Console.exe sip\sip
	echo SIP is now running.
	SET sips=SIP is running.
)

QPROCESS * | find /I /N "icecast.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	echo Icecast is already running.
)else (
	Console.exe icecast\bin\icecast.exe -c .\icecast\icecast.xml
	echo Icecast is now running.
	SET ices=Icecast is running.
)

title AP Server : Start
pause
goto main

:label2
QPROCESS * | find /I /N "mysqld.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	taskkill /F /IM mysqld.exe>NUL
	echo MYSQLD ended successfully.
	SET sqls=MYSQL is not running.
)else (
	echo MYSQLD is not running
)

QPROCESS * | find /I /N "httpd.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	::httpd -s stop
	taskkill /F /IM httpd.exe>NUL
	echo Apache ended successfully.
	SET apaches=Apache is not running.
)else (
	echo Apache is not running
)

QPROCESS * | find /I /N "php-cgi.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	taskkill /F /IM php-cgi.exe>NUL
	echo PHP ended successfully.
	SET phps=PHP is not running.
)else (
	echo PHP is not running
)

QPROCESS * | find /I /N "sip.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	taskkill /F /IM sip.exe>NUL
	echo SIP ended successfully.
	SET sips=SIP is not running.
)else (
	echo SIP is not running
)

QPROCESS * | find /I /N "icecast.exe">NUL
IF "%ERRORLEVEL%"=="0" (
	taskkill /F /IM icecast.exe>NUL
	echo icecast ended successfully.
	SET ices=Icecast is not running.
)else (
	echo Icecast is not running
)

title AP Server : Stop
pause
goto main

:label3
cls
echo Server is trying to restart.
apache\bin\httpd -k restart
SET apaches=Apache is restart.
SET phps=PHP is restart.
SET sqls=MYSQL is restart.
SET sips=SIP is restart.
SET ices=Icecast is restart.
cls
echo Status: Server is restart.
title AP Server : Restart
pause
goto main


:label4
cls
echo Server is trying to shutdown.
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO main
Console.exe apache\bin\httpd -k shutdown
Console.exe mysql\bin\mysqladmin -u root shutdown
taskkill /IM httpd.exe /F
taskkill /IM mysql.exe /F
taskkill /IM mysqld.exe /F
taskkill /IM php-cgi.exe /F
taskkill /IM sip.exe /F
taskkill /IM icecast.exe /F
SET apaches=Apache is shutdown.
SET phps=PHP is shutdown.
SET sqls=MYSQL is shutdown.
SET sips=SIP is shutdown.
SET ices=Icecast is shutdown.
cls
title AP Server : Shutdown
goto main

:label5
cls
echo Admin is opening...
start http://localhost
cls
goto main

:label6
cls
echo phpMyAdmin is opening...
start http://localhost/phpMyadmin/
cls
goto main

:label7
cls
echo SIP Admin is opening...
start http://localhost:8080
cls
goto main

:label8
cls
echo SIP Admin is opening...
start http://localhost:8000
cls
goto main

:label9
cls
echo Backup is creating...
move backup\www.zip backup\log
ren backup\log\www.zip WWW-Backup-%time:~0,2%%time:~3,2%%time:~6,2%_%date:~-10,2%%date:~-7,2%%date:~-4,4%.zip
cls
echo Backup is creating...
powershell Compress-Archive www backup\www.zip
cls
title AP Server : Backup Completed
goto main

:label10
cls
echo Backup is restoring...
powershell expand-archive backup\www.zip %CD:~0,3%\apserver\
cls
title AP Server : Backup Restored
goto main

:label11
cls
echo Clear log file!
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO :main
cls
echo Log file is cleaning..?
del /q/f/s backup\log\*
cls
title AP Server : Log Cleared
goto main

:label12
cls
echo Reset Browser Settings!
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO :main
cls

echo Browser is resting...

@rem Clear IE cache -  (Deletes Temporary Internet Files Only)
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
erase "%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*") do RD /S /Q "%%i"

@rem Clear Google Chrome cache
erase "%LOCALAPPDATA%\Google\Chrome\User Data\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\*") do RD /S /Q "%%i"


@rem Clear Firefox cache
erase "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.*" /f /s /q
for /D %%i in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do RD /S /Q "%%i"

erase "%ALLUSERSPROFILE%\TEMP\*.*" /f /s /q
for /D %%i in ("%ALLUSERSPROFILE%\TEMP\*") do RD /S /Q "%%i"

erase "%SystemRoot%\TEMP\*.*" /f /s /q
for /D %%i in ("%SystemRoot%\TEMP\*") do RD /S /Q "%%i"
erase "%TEMP%\*.*" /f /s /q
for /D %%i in ("%TEMP%\*") do RD /S /Q "%%i"

erase "%TMP%\*.*" /f /s /q
for /D %%i in ("%TMP%\*") do RD /S /Q "%%i"
cls
title AP Server : Browser Reset Completed
goto main

:label13
cls
echo Root is opening...
start %CD:~0,3%\apserver\
cls
goto main

:label14
cls
echo About is opening...
start support\about.txt
cls
goto main

:label15
cls
echo Readme is opening...
start support\readme.txt
cls
goto main

:label16
cls
echo Server runnig in background continue...
@echo off
setlocal
:PROMPT
SET /P AREYOUSURE=Are you sure want to run in background (Y/[N])?
IF /I "%AREYOUSURE%" NEQ "Y" GOTO :main
exit
