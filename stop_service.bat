@echo off
Title APServer Stop Service
Console.exe apache\bin\httpd -k stop
Console.exe apache\bin\httpd -k uninstall
Console.exe apache\bin\httpd -k shutdown
Console.exe mysql\bin\mysqladmin -u root shutdown
Console.exe mysql\bin\mysqld stop
Console.exe mysql\bin\mysql uninstall
taskkill /IM httpd.exe /F
taskkill /IM mysql.exe /F
taskkill /IM mysqld.exe /F
taskkill /IM php-cgi.exe /F
taskkill /IM mysqladmin.exe /F
taskkill /IM sip.exe /F
taskkill /IM icecast.exe /F