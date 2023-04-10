Echo off
:: %0 is currently running batch file
echo running %0

:: copy the xml file to the execution directory
copy D:\Projects\Statline\GenerateSQL\GenerateSQLList.xml D:\Projects\Statline\GenerateSQL\bin\Debug

:: change the current directory GenerateSQL.exe directory
:: before changing the directory set the current directory
:: %~dp0 set the compand file folder 
set cmdFileFolder=%~dp0
CD D:\Projects\Statline\GenerateSQL\bin\Debug\

:: generate the release sql file. Call the command and specify the files to generate
:: this instance is running only the ST2008 instance.
call Statline.GenerateSQL.exe StatTracCCRST159
call Statline.GenerateSQL.exe StatTracCCRST159AT
call Statline.GenerateSQL.exe StatTracCCRST159DW
::call Statline.GenerateSQL.exe StatTracCCRST159DMVCO

copy D:\Projects\Statline\StatTrac\Development\Main\Database\Queries\Statline.StatTrac.database.sql \\st-devsql-2\C$\RM_Scripts\StatTrac
copy D:\Projects\Statline\StatTrac\Development\Main\Database\Queries\Statline.Stattrac.AT.sql \\st-devsql-2\C$\RM_Scripts\StatTrac
copy D:\Projects\Statline\StatTrac\Development\Main\Database\Queries\Statline.Stattrac.DW.sql \\st-devsql-2\C$\RM_Scripts\StatTrac
::copy D:\Projects\Statline\StatTrac\Development\Main\Database\Queries\Statline.Stattrac.DMV_CO.sql \\st-devsql-2\C$\RM_Scripts\StatTrac

:: call script to release to development
:: first reset the folder back to batch diretory
cd %cmdFileFolder%

:: now call your personall developmentRelease.cmd file
::call developmentRelease.cmd
