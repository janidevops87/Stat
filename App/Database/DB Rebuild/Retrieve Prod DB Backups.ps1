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

# Get relevant SQL backups from stsqloltp
Function GetProdBackups {
    [CmdletBinding()]
    param()

    $server = $env:ProdServer
    $database = $env:ProdDb
    $toDate = Get-Date -Date (Get-Date).ToUniversalTime() -Format "yyyy-MM-dd HH:mm:ss.fff"

    # Run query
    return GetBackups -toDate $toDate -server $server -database $database -username $env:ProdDbUsername -password $env:ProdDbPassword
}

# Get relevant SQL backups from sqlrpt._ReferralAuditTrail
Function GetAuditTrailBackups {
    [CmdletBinding()]
    param($TransactionalBackups)

    $server = $env:ProdAtServer
    $database = $env:ProdAtDb
    $toDate = ($TransactionalBackups | %{ $_.BackupStartDate } | Measure -Max).Maximum

    # Run query
    return GetBackups -toDate $toDate -server $server -database $database -username $env:ProdAtDbUsername -password $env:ProdAtDbPassword
}

# Generic function to retrieve SQL backups
# Reference: https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/restoring-from-backups-stored-in-microsoft-azure?view=sql-server-ver15
# Reference: https://www.mikefal.net/2015/10/13/a-month-of-sql-ps-backups-and-restores/
Function GetBackups {
    [CmdletBinding()]
    param($toDate, $server, $database, $username, $password)

    $query = "
    DECLARE @BackupPaths TABLE (
	    BPBackupPath NVARCHAR(MAX),
	    BPStartDate DATETIME
    )
    
    INSERT INTO @BackupPaths
	    SELECT TOP 1 backup_path, backup_start_date
		    FROM managed_backup.fn_available_backups('$database')
		    WHERE backup_type = 'DB'
                AND backup_start_date < '$toDate'
		    ORDER BY backup_start_date DESC;
    
    INSERT INTO @BackupPaths
	    SELECT TOP 1000 backup_path, backup_start_date
		    FROM managed_backup.fn_available_backups('$database')
		    WHERE backup_type = 'Log'
			    AND backup_start_date > (SELECT TOP 1 BPStartDate FROM @BackupPaths)
                AND backup_start_date < '$toDate'
		    ORDER BY backup_start_date ASC;
    
    SELECT * FROM @BackupPaths ORDER BY BPStartDate ASC
    
    GO"
    
    # Run query
    Write-Host "Getting backups from $server\$database...`n"
    $queryResult = Invoke-Sqlcmd -OutputSqlErrors $true -Verbose -ServerInstance $server -Database "msdb" -Username $username -Password $password -Query $query -QueryTimeout 10000 -ErrorAction Stop -As DataTables
    
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

$backupPaths = GetProdBackups -ErrorAction Stop
$backupPathsJson = $backupPaths.BackupPath | ConvertTo-Json -Compress
Write-Host "##vso[task.setvariable variable=ProdBackupPathsJson;]$backupPathsJson"

$atBackupPaths = GetAuditTrailBackups -TransactionalBackups $backupPaths -ErrorAction Stop
$atBackupPathsJson = $atBackupPaths.BackupPath | ConvertTo-Json -Compress
Write-Host "##vso[task.setvariable variable=ProdAtBackupPathsJson;]$atBackupPathsJson"