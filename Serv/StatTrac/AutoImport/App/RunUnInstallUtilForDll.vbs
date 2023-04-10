Dim p_ID

Dim FullPath

FullPath="RunUnInstallUtilForDLL.cmd"

set objShell = Wscript.CreateObject("Wscript.Shell")

p_ID = objShell.Run(FullPath)
