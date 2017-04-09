@echo off
if "%1" == "h" goto begin
mshta vbscript:createobject("wscript.shell").run(""%0" h",0)(window.close)&&exit
:begin
powershell "%VBOX_MSI_INSTALL_PATH%\VBoxManage.exe" startvm default --type headless
exit
