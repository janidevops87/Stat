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

# Get relevant SQL backups from prod DB
Function GetProdBackups {
    [CmdletBinding()]
    param($Database, $Server, $TransactionalBackups, $Username, $Password)

    if ($TransactionalBackups.Length > 0) {
        $toDate = ($TransactionalBackups | %{ $_.BackupStartDate } | Measure -Max).Maximum
    }
    else {
        $toDate = Get-Date -Date (Get-Date).ToUniversalTime() -Format "yyyy-MM-dd HH:mm:ss.fff"
    }

    # Run query
    return GetBackups -toDate $toDate -server $Server -database $Database -username $Username -password $Password
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

$backupPaths = GetProdBackups `
                    -Database $env:ProdTxnDb `
                    -Server $env:ProdServer `
                    -Username $env:ProdDbUsername `
                    -Password $env:ProdDbPassword `
                    -ErrorAction Stop
$backupPathsJson = $backupPaths.BackupPath | ConvertTo-Json -Compress
Write-Host "##vso[task.setvariable variable=ProdTxnBackupPathsJson;]$backupPathsJson"

# Only get Audit Trail (AT) backups if rebuild environment is one that needs it
if ($env:RebuildEnvironment -in (($env:AtRebuildEnvironments) -split ',')) {
    $atBackupPathsJson = (GetProdBackups `
                            -TransactionalBackups $backupPaths `
                            -Database $env:ProdAtDb `
                            -Server $env:ProdAtServer `
                            -Username $env:ProdAtDbUsername `
                            -Password $env:ProdAtDbPassword `
                            -ErrorAction Stop).BackupPath | ConvertTo-Json -Compress

    Write-Host "##vso[task.setvariable variable=ProdAtBackupPathsJson;]$atBackupPathsJson"
}

# Only get Data Warehouse (DW) backups if rebuild environment is one that needs it
if ($env:RebuildEnvironment -in (($env:DwRebuildEnvironments) -split ',')) {
    $dwBackupPathsJson = (GetProdBackups `
                            -Database $env:ProdDwDb `
                            -Server $env:ProdAtServer `
                            -Username $env:ProdAtDbUsername `
                            -Password $env:ProdAtDbPassword `
                            -ErrorAction Stop).BackupPath | ConvertTo-Json -Compress
    Write-Host "##vso[task.setvariable variable=ProdDwBackupPathsJson;]$dwBackupPathsJson"
}

# Only get Reporting (Rpt) backups if rebuild environment is one that needs it
if ($env:RebuildEnvironment -in (($env:RptRebuildEnvironments) -split ',')) {
    $rptBackupPathsJson = (GetProdBackups `
                            -Database $env:ProdRptDb `
                            -Server $env:ProdAtServer `
                            -Username $env:ProdAtDbUsername `
                            -Password $env:ProdAtDbPassword `
                            -ErrorAction Stop).BackupPath | ConvertTo-Json -Compress
    Write-Host "##vso[task.setvariable variable=ProdRptBackupPathsJson;]$rptBackupPathsJson"
}