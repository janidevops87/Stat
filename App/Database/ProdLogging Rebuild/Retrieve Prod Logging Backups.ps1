# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

If ((Get-InstalledModule -Name SqlServer -ErrorAction SilentlyContinue) -eq $null) {
    Install-Module SqlServer -Scope CurrentUser -AllowClobber -ErrorAction Stop -Force
}

If ((Get-Module -ListAvailable -Name SqlServer -ErrorAction SilentlyContinue) -eq $null) {
    Import-Module SqlServer -ErrorAction Stop
}

# Controls whether full list of backups are printed to console (restore is still performed)
try {
    $writeBackupPaths = [System.Convert]::ToBoolean($env:WriteBackupPaths)
}
catch [FormatException] {
    $writeBackupPaths = $false
}

# Get relevant SQL backups from sqlrpt Logging DB
# Reference: https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/restoring-from-backups-stored-in-microsoft-azure?view=sql-server-ver15
# Reference: https://www.mikefal.net/2015/10/13/a-month-of-sql-ps-backups-and-restores/
Function GetProductionLoggingBackups {
    [CmdletBinding()]
    param($Server, $Database, $Username, $Password)

    $query = "
    DECLARE @BackupPaths TABLE (
	    BPBackupPath NVARCHAR(MAX),
	    BPStartDate DATETIME
    )

    INSERT INTO @BackupPaths
	    SELECT TOP 1 backup_path, backup_start_date
		    FROM managed_backup.fn_available_backups('$database')
		    WHERE backup_type = 'DB'
		    ORDER BY backup_start_date DESC;

    INSERT INTO @BackupPaths
	    SELECT TOP 1000 backup_path, backup_start_date
		    FROM managed_backup.fn_available_backups('$database')
		    WHERE backup_type = 'Log'
			    AND backup_start_date > (SELECT TOP 1 BPStartDate FROM @BackupPaths)
		    ORDER BY backup_start_date ASC;

    SELECT * FROM @BackupPaths ORDER BY BPStartDate ASC

    GO"

    # Run query
    Write-Host "Getting backups from $server\$database...`n"
    $queryResult = Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $server -Database "msdb" -Username $Username -Password $Password -Query $query -QueryTimeout 1000 -ErrorAction Stop -As DataTables

    # Pull backup paths from query results
    $backupPaths = $queryResult[0].Rows | %{ New-Object PSObject -Property @{ BackupPath = $_.BPBackupPath; BackupStartDate = $_.BPStartDate } }
    
    Write-Host "Received $($backupPaths.Length) backup results"
    
    if ($writeBackupPaths) {
        Write-Host "Backup paths:"
        $backupPaths | %{ Write-Host $_ }
        Write-Host "`n"
    }

    return $backupPaths
}


# Run query
$backupPaths = GetProductionLoggingBackups -Server $env:ProdLogServer -Database $env:ProdLogDb -Username $env:ProdLogDbUsername -Password $env:ProdLogDbUserPassword -ErrorAction Stop
$backupPathsJson = $backupPaths | ConvertTo-Json -Compress
Write-Host "##vso[task.setvariable variable=ProdLogBackupPathsJson;]$backupPathsJson"