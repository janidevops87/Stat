# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

If ((Get-InstalledModule -Name SqlServer -ErrorAction SilentlyContinue) -eq $null) {
    Install-Module SqlServer -Scope CurrentUser -AllowClobber -ErrorAction Stop -Force
}

If ((Get-Module -ListAvailable -Name SqlServer -ErrorAction SilentlyContinue) -eq $null) {
    Import-Module SqlServer -ErrorAction Stop
}

# Restore DB
# Reference: https://docs.microsoft.com/en-us/powershell/module/sqlserver/restore-sqldatabase?view=sqlserver-ps
Function RestoreDB {
    [CmdletBinding()]
    param($BackupPaths, $Server, $Database, $SourceData, $DestData, $SourceIndex, $DestIndex, $SourceLog, $DestLog)

    if ($BackupPaths -is [array]) {
        $count = $BackupPaths.Length
    }
    else {
        $count = 1
    }

    Write-Host "Restoring $count backups to $Server\$Database...`n"

    # Restore each backup
    foreach ($backup in $BackupPaths) {
        Write-Host "Restoring from $backup on $Server\$Database..."

        $restoreQuery = ""

        if ($backup -like "*.bak") {
            # Need to set DB to single_user before first restore
            $restoreQuery = "
            -- Check if db is in restoring state and alter db if not.
            IF EXISTS(select 1 from sys.databases where name like '$Database' and state <> 1) -- State = 1 = Restoring
            BEGIN
                ALTER DATABASE [$Database] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
            END
            GO

            "

            if ($count -eq 1) {
                # .bak only
                $restoreQuery += "
                RESTORE DATABASE [$Database] FROM URL = '$backup'
                    WITH MOVE '$SourceData' TO '$DestData', MOVE '$SourceIndex' TO '$DestIndex', MOVE '$SourceLog' TO '$DestLog',
                    RECOVERY, NOUNLOAD, REPLACE, STATS = 5

                GO"
            }
            else {
                # .bak first
                $restoreQuery += "
                RESTORE DATABASE [$Database] FROM URL = '$backup'
                    WITH MOVE '$SourceData' TO '$DestData', MOVE '$SourceIndex' TO '$DestIndex', MOVE '$SourceLog' TO '$DestLog',
                    NORECOVERY, NOUNLOAD, REPLACE, STATS = 5

                GO"
            }
        }
        elseif ($backup -eq $BackupPaths[$BackupPaths.Length - 1]) {
            # last log
            $restoreQuery = "
            RESTORE LOG [$Database] FROM URL = '$backup'
                WITH MOVE '$SourceData' TO '$DestData', MOVE '$SourceIndex' TO '$DestIndex', MOVE '$SourceLog' TO '$DestLog',
                RECOVERY, NOUNLOAD, STATS = 5

            GO"
        }
        else {
            # log
            $restoreQuery = "
            RESTORE LOG [$Database] FROM URL = '$backup'
                WITH MOVE '$SourceData' TO '$DestData', MOVE '$SourceIndex' TO '$DestIndex', MOVE '$SourceLog' TO '$DestLog',
                NORECOVERY, NOUNLOAD, STATS = 5

            GO"
        }
        
        #Write-Host $restoreQuery
        Invoke-Sqlcmd -ServerInstance $Server -Database "master" -Username $env:DestPlnUser -Password $env:DestPlnUserPassword -Query $restoreQuery -OutputSqlErrors $true -QueryTimeout 0 -Verbose -ErrorAction Stop
    }

    Write-Host "$Server\$Database successfully restored"
}

# Restore DB
$prodBackupPaths = $env:RestoreBackupPathsJson | ConvertFrom-Json
RestoreDB -BackupPaths $prodBackupPaths `
    -Server $env:DestServer `
    -Database $env:RestoreDestDatabase `
    -SourceData $env:RestoreSourceData `
    -DestData $env:RestoreDestData `
    -SourceIndex $env:RestoreSourceIndex `
    -DestIndex $env:RestoreDestIndex `
    -SourceLog $env:RestoreSourceLog `
    -DestLog $env:RestoreDestLog `
    -Verbose -ErrorAction Stop