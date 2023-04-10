# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Add directory to PSModulePath so hosted build agent can find PS modules
#Save the current value in the $p variable.
$p = [Environment]::GetEnvironmentVariable("PSModulePath")

#Add the new path to the $p variable. Begin with a semi-colon separator.
$p += ";C:\WINDOWS\ServiceProfiles\NetworkService\Documents\WindowsPowerShell\Modules\"

#Add the paths in $p to the PSModulePath value.
[Environment]::SetEnvironmentVariable("PSModulePath",$p)
Write-Host "PSModulePath: $p"

If ((Get-InstalledModule -Name VSTeam -ErrorAction SilentlyContinue) -eq $null) {
    Install-Module VSTeam -Scope CurrentUser -AllowClobber -Verbose -ErrorAction Stop -Force
    Write-Host "VSTeam module installed"
}
else {
    Write-Host "VSTeam module already installed"
}

If ((Get-Module -ListAvailable -Name VSTeam -ErrorAction SilentlyContinue) -eq $null) {
    Import-Module VSTeam -Verbose -ErrorAction Stop
    Write-Host "VSTeam module imported"
}
else {
    Write-Host "VSTeam module already imported"
}


if ($env:RebuildEnvironment -eq 'dev') {
    Write-Host "Setting environment vars for dev rebuild"
    
    $vars = @(
        $(New-Object PSObject -Property @{ Name = "DestServer"; Value = $env:DevServer; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestPlnUser"; Value = $env:DevPipelineUser; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestPlnUserPassword"; Value = $env:DevPlnUserPassword; IsSecret = $true }),
        $(New-Object PSObject -Property @{ Name = "DestLogins"; Value = $env:DevDbLogins; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestTxnDatabase"; Value = $env:DevTxnDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnData"; Value = $env:DevTxnData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnIndex"; Value = $env:DevTxnIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnLog"; Value = $env:DevTxnLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdTxnBackupPathsJson"; Value = $env:ProdTxnBackupPathsJson; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestAtDatabase"; Value = $env:DevAtDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtUser"; Value = $env:DevAtUser; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtData"; Value = $env:DevAtData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtIndex"; Value = $env:DevAtIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtLog"; Value = $env:DevAtLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdAtBackupPathsJson"; Value = $env:ProdAtBackupPathsJson; IsSecret = $false })
    )
}
elseif ($env:RebuildEnvironment -eq 'test') {
    Write-Host "Setting environment vars for test rebuild"
    
    $vars = @(
        $(New-Object PSObject -Property @{ Name = "DestServer"; Value = $env:TestServer; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DistributorServer"; Value = $env:TestDistributorServer; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestPlnUser"; Value = $env:TestPipelineUser; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestPlnUserPassword"; Value = $env:TestPlnUserPassword; IsSecret = $true }),
        $(New-Object PSObject -Property @{ Name = "DestLogins"; Value = $env:TestDbLogins; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestTxnDatabase"; Value = $env:TestTxnDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnData"; Value = $env:TestTxnData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnIndex"; Value = $env:TestTxnIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnLog"; Value = $env:TestTxnLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdTxnBackupPathsJson"; Value = $env:ProdTxnBackupPathsJson; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestAtDatabase"; Value = $env:TestAtDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtUser"; Value = $env:TestAtUser; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtData"; Value = $env:TestAtData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtIndex"; Value = $env:TestAtIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtLog"; Value = $env:TestAtLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdAtBackupPathsJson"; Value = $env:ProdAtBackupPathsJson; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestDwDatabase"; Value = $env:TestDwDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestDwData"; Value = $env:TestDwData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestDwIndex"; Value = $env:TestDwIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestDwLog"; Value = $env:TestDwLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdDwBackupPathsJson"; Value = $env:ProdDwBackupPathsJson; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestRptDatabase"; Value = $env:TestRptDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestRptData"; Value = $env:TestRptData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestRptIndex"; Value = $env:TestRptIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestRptLog"; Value = $env:TestRptLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdRptBackupPathsJson"; Value = $env:ProdRptBackupPathsJson; IsSecret = $false })
    )
}
elseif ($env:RebuildEnvironment -eq 'test2') {
    Write-Host "Setting environment vars for test2 rebuild"
    
    $vars = @(
        $(New-Object PSObject -Property @{ Name = "DestServer"; Value = $env:Test2Server; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestPlnUser"; Value = $env:Test2PipelineUser; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestPlnUserPassword"; Value = $env:Test2PlnUserPassword; IsSecret = $true }),
        $(New-Object PSObject -Property @{ Name = "DestLogins"; Value = $env:Test2DbLogins; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestTxnDatabase"; Value = $env:Test2TxnDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnData"; Value = $env:Test2TxnData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnIndex"; Value = $env:Test2TxnIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnLog"; Value = $env:Test2TxnLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdTxnBackupPathsJson"; Value = $env:ProdTxnBackupPathsJson; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestAtDatabase"; Value = $env:Test2AtDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtUser"; Value = $env:Test2AtUser; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtData"; Value = $env:Test2AtData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtIndex"; Value = $env:Test2AtIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestAtLog"; Value = $env:Test2AtLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdAtBackupPathsJson"; Value = $env:ProdAtBackupPathsJson; IsSecret = $false })
    )
}
elseif ($env:RebuildEnvironment -eq 'training') {
    Write-Host "Setting environment vars for training rebuild"

    $vars = @(
        $(New-Object PSObject -Property @{ Name = "DestServer"; Value = $env:TrngServer; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestPlnUser"; Value = $env:TrngPipelineUser; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestPlnUserPassword"; Value = $env:TrngPlnUserPassword; IsSecret = $true }),
        $(New-Object PSObject -Property @{ Name = "DestLogins"; Value = $env:TrngDbLogins; IsSecret = $false }),

        $(New-Object PSObject -Property @{ Name = "DestTxnDatabase"; Value = $env:TrngTxnDatabase; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnData"; Value = $env:TrngTxnData; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnIndex"; Value = $env:TrngTxnIndex; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "DestTxnLog"; Value = $env:TrngTxnLog; IsSecret = $false }),
        $(New-Object PSObject -Property @{ Name = "ProdTxnBackupPathsJson"; Value = $env:ProdTxnBackupPathsJson; IsSecret = $false })
    )
}
else {
    Write-Error -Message "Invalid rebuild environment: $($env:RebuildEnvironment)" -ErrorAction Stop
}

# Create release vars
foreach ($var in $vars) {
    Set-VSTeamAccount -Account "Statline" -PersonalAccessToken $env:ReleaseDefinitionPat
    $r = Get-VSTeamRelease -ProjectName $env:System_TeamProject -Id $env:Release_ReleaseId -Raw
    $r.variables | Add-Member NoteProperty $($var.Name)([PSCustomObject]@{value=$($var.Value);isSecret=$($var.IsSecret)})
    Update-VSTeamRelease -ProjectName $env:System_TeamProject -Id $env:Release_ReleaseId -Release $r -Force
}