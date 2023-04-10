SET Service_Name=StatRespond
SET Exe_Path="C:\Program Files (x86)\Statline\StatRespond\Statline.StatTrac.StatRespond.Windows.Service.exe"

sc stop %Service_Name%
sc delete %Service_Name%
pause
sc create %Service_Name% DisplayName= %Service_Name% binpath= %Exe_Path% start= auto
sc start %Service_Name%
pause

