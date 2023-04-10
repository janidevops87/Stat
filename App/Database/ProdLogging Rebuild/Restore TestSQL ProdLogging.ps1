# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

If ((Get-InstalledModule -Name SqlServer -ErrorAction SilentlyContinue) -eq $null) {
    Install-Module SqlServer -Scope CurrentUser -AllowClobber -ErrorAction Stop -Force
}

If ((Get-Module -ListAvailable -Name SqlServer -ErrorAction SilentlyContinue) -eq $null) {
    Import-Module SqlServer -ErrorAction Stop
}

# Restore logging DB
# Reference: https://docs.microsoft.com/en-us/powershell/module/sqlserver/restore-sqldatabase?view=sqlserver-ps
Function RestoreLoggingDB {
    [CmdletBinding()]
    param($BackupPaths, $Server, $Database, $DestData, $DestLog)

    if ($Database -like "*Logging*") {
        $SourceData = $env:ProdData
        $SourceLog = $env:ProdLog
    }
    else {
        throw "Invalid value for source DB $Server\$($Database). Operation cancelled."
    }

    Write-Host "Restoring $Server\$Database...`n"

    $count = 0
    foreach ($backupObj in $BackupPaths) {
        $count++
    }

    # Restore each backup
    foreach ($backupObj in $BackupPaths) {
        $backup = $backupObj.BackupPath
        Write-Host "Run this command to fix $Database being stuck in Restoring state if something goes wrong:`nRESTORE DATABASE [$Database] WITH RECOVERY`n"
        Write-Host "Restoring from $backup on $Server\$Database..."
    
        $restoreQuery = ""
    
        if ($backup -like "*.bak") {
            # Need to set DB to single_user before first restore
            $restoreQuery = "
            ALTER DATABASE [$Database] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
            GO
    
            "
            
            if ($count -eq 1) {
                # .bak only
                $restoreQuery += "
                RESTORE DATABASE [$Database] FROM URL = '$backup'
                    WITH MOVE '$SourceData' TO '$DestData', MOVE '$SourceLog' TO '$DestLog',
                    RECOVERY, NOUNLOAD, REPLACE, STATS = 5
    
                GO"
            }
            else {
                # .bak first
                $restoreQuery += "
                RESTORE DATABASE [$Database] FROM URL = '$backup'
                    WITH MOVE '$SourceData' TO '$DestData', MOVE '$SourceLog' TO '$DestLog',
                    NORECOVERY, NOUNLOAD, REPLACE, STATS = 5
    
                GO"
            }
        }
        elseif ($backupObj -eq $BackupPaths[$BackupPaths.Length - 1]) {
            # last log
            $restoreQuery = "
            RESTORE LOG [$Database] FROM URL = '$backup'
                WITH MOVE '$SourceData' TO '$DestData', MOVE '$SourceLog' TO '$DestLog',
                RECOVERY, NOUNLOAD, STATS = 5
    
            GO"
        }
        else {
            # log
            $restoreQuery = "
            RESTORE LOG [$Database] FROM URL = '$backup'
                WITH MOVE '$SourceData' TO '$DestData', MOVE '$SourceLog' TO '$DestLog',
                NORECOVERY, NOUNLOAD, STATS = 5
    
            GO"
        }
    
        #Write-Host $restoreQuery
        Invoke-Sqlcmd -ServerInstance $Server -Database "master" -Query $restoreQuery -Username $env:TestLogDbUsername -Password $env:TestLogDbUserPassword -OutputSqlErrors $true -QueryTimeout 0 -Verbose -ErrorAction Stop
        Write-Host "`n"
    }

    Write-Host "$Server\$Database successfully restored"
}

$prodBackupPaths = $env:ProdLogBackupPathsJson | ConvertFrom-Json
RestoreLoggingDB -BackupPaths $prodBackupPaths -Server $env:TestLogServer -Database $env:TestLogDb -DestData $env:TestData -DestLog $env:TestLog -Verbose -ErrorAction Stop