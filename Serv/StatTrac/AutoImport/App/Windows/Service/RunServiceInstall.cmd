SET Service_Name=AutoImport
SET Exe_Path="C:\Program Files (x86)\Statline\AutoImport\Statline.StatTrac.AutoImport.Windows.Service.exe"

sc stop %Service_Name%
sc delete %Service_Name%
pause
sc create %Service_Name% DisplayName= %Service_Name% binpath= %Exe_Path% start= auto
sc start %Service_Name%
pause

