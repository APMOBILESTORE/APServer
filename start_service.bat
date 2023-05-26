@echo off
Title APServer Start Service

md %CD:~0,2%\APServer\backup
md %CD:~0,2%\APServer\backup\log
del %CD:~0,2%\APServer\apache\htdocs\index.html
move %CD:~0,2%\APServer\apache\htdocs %CD:~0,2%\APServer\htdocs
ren htdocs www
move %CD:~0,2%\APServer\support\index.php %CD:~0,2%\APServer\www\index.php
move %CD:~0,2%\APServer\support\phpmyadmin %CD:~0,2%\APServer\www\phpmyadmin
move %CD:~0,2%\APServer\support\server.crt %CD:~0,2%\APServer\apache\conf\server.crt
move %CD:~0,2%\APServer\support\server.key %CD:~0,2%\APServer\apache\conf\server.key

cd apache\conf
set "sourcefile=httpd.conf"
set "tempfile=httpd.txt"
set "finalfilename=httpd.conf"
set  search1=c:/Apache24
set replace1=%CD:~0,2%/APServer/apache
set  search2=#ServerName www.example.com:80
set replace2=ServerName www.example.com:80
set  search3=${SRVROOT}/htdocs
set replace3=%CD:~0,2%/APServer/www
set  search4=DirectoryIndex index.html
set replace4=DirectoryIndex index.php index.html
set  search5=#LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
set replace5=LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
set  search6=#LoadModule ssl_module modules/mod_ssl.so
set replace6=LoadModule ssl_module modules/mod_ssl.so
set  search7=#Include conf/extra/httpd-ssl.conf
set replace7=Include conf/extra/httpd-ssl.conf
(for /f "delims=" %%i in (%sourcefile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:%search1%=%replace1%!"
	set "line=!line:%search2%=%replace2%!"
	set "line=!line:%search3%=%replace3%!"
	set "line=!line:%search4%=%replace4%!"
	set "line=!line:%search5%=%replace5%!"
	set "line=!line:%search6%=%replace6%!"
	set "line=!line:%search7%=%replace7%!"
    echo(!line!
    endlocal
))>"%tempfile%"
del %finalfilename%
rename %tempfile%  %finalfilename%

echo ###PHP Config >> httpd.conf 
	echo PHPIniDir "%CD:~0,2%/APServer/php" >> httpd.conf
		echo AddHandler application/x-httpd-php .php >> httpd.conf
		echo LoadModule php_module "%CD:~0,2%/APServer/php/php8apache2_4.dll" >> httpd.conf
		
cd extra
set "sourcefile=httpd-ssl.conf"
set "tempfile=httpd-ssl.txt"
set "finalfilename=httpd-ssl.conf"
set  search1=${SRVROOT}/htdocs
set replace1=%CD:~0,2%/APServer/www
(for /f "delims=" %%i in (%sourcefile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:%search1%=%replace1%!"
    echo(!line!
    endlocal
))>"%tempfile%"
del %finalfilename%
rename %tempfile%  %finalfilename%
cd..\..\..\

cd php
copy php.ini-development php.ini
echo extension_dir = "%CD:~0,2%\APServer\php\ext" >> php.ini
echo extension=ldap >> php.ini
echo extension=curl >> php.ini
echo extension=ffi >> php.ini
echo extension=ftp >> php.ini
echo extension=fileinfo >> php.ini
echo extension=gd >> php.ini
echo extension=gettext >> php.ini
echo extension=gmp >> php.ini
echo extension=intl >> php.ini
echo extension=imap >> php.ini
echo extension=mbstring >> php.ini
echo extension=exif >> php.ini
echo extension=mysqli >> php.ini
echo extension=oci8_12c >> php.ini
echo extension=oci8_19 >> php.ini
echo extension=odbc >> php.ini
echo extension=openssl >> php.ini
echo extension=pdo_firebird >> php.ini
echo extension=pdo_mysql >> php.ini
echo extension=pdo_oci >> php.ini
echo extension=pdo_odbc >> php.ini
echo extension=pdo_pgsql >> php.ini
echo extension=pdo_sqlite >> php.ini
echo extension=pgsql >> php.ini
echo extension=shmop >> php.ini
echo extension=soap >> php.ini
echo extension=sockets >> php.ini
echo extension=sodium >> php.ini
echo extension=sqlite3 >> php.ini
echo extension=tidy >> php.ini
echo extension=xsl >> php.ini
echo extension=zip >> php.ini
cd..\

cd www\phpMyAdmin
copy config.sample.inc.php config.inc.php
set "sourcefile=config.inc.php"
set "tempfile=config.inc.txt"
set "finalfilename=config.inc.php"
set  search1=''; /*
set replace1='JOFw435365IScA1Q5cDugrglSfuAz5OW'; /*
set  search2=false;
set replace2=true;
(for /f "delims=" %%i in (%sourcefile%) do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    set "line=!line:%search1%=%replace1%!"
	set "line=!line:%search2%=%replace2%!"
    echo(!line!
    endlocal
))>"%tempfile%"
del %finalfilename%
rename %tempfile%  %finalfilename%

echo $cfg['Servers'][$i]['port'] = ''; >> config.inc.php
echo $cfg['Servers'][$i]['socket'] = ''; >> config.inc.php
echo $cfg['Servers'][$i]['connect_type'] = 'tcp'; >> config.inc.php
echo $cfg['Servers'][$i]['extension'] = 'mysqli'; >> config.inc.php
echo $cfg['Servers'][$i]['user'] = 'root'; >> config.inc.php
echo $cfg['Servers'][$i]['password'] = ''; >> config.inc.php
echo $cfg['Servers'][$i]['nopassword'] = true; >> config.inc.php
echo $cfg['ServerDefault'] = 1; >> config.inc.php
echo $cfg['DefaultLang'] = 'en'; >> config.inc.php
cd..\..\

Console.exe php\php-cgi -b 127.0.0.1:9000
Console.exe apache\bin\httpd -k install
Console.exe apache\bin\httpd -k start
Console.exe mysql\bin\mysqld --initialize-insecure
Console.exe mysql\bin\mysql install
Console.exe mysql\bin\mysqld --console
Console.exe mysql\bin\mysql -u root
Console.exe mysql\bin\mysqld
Console.exe sip\sip
Console.exe icecast\bin\icecast.exe -c .\icecast\icecast.xml

setx /M PATH "%PATH%;%CD:~0,2%\APServer\mysql\bin"