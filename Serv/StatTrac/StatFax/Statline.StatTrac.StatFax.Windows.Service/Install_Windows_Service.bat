REM ### The Exe_Path is determined dynamically. %~d0 = the drive letter in the path of the batch script, %~p0 is the path (without the drive letter) to the batch script. (Not including the script name.)
SET Service_Name=StatTracStatFaxDev
SET Exe_Path=%~d0%~p0\Statline.StatTrac.StatFax.Windows.Service.exe

sc stop %Service_Name%
sc delete %Service_Name%
pause
sc create %Service_Name% binpath= "%Exe_Path%" DisplayName= %Service_Name% start= auto obj= "doggy\statfaxadmin" password= "statfaxadmin"
sc start %Service_Name%
pause
