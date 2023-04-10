if ($env:REBUILDENVIRONMENT -eq 'test') {
    Write-Host "Setting environment vars for test rebuild"

    # Restore vars
    Write-Host "##vso[task.setvariable variable=DestServer;]$env:TESTSERVER"
    Write-Host "##vso[task.setvariable variable=DestDatabase;]$env:TESTDATABASE"
    Write-Host "##vso[task.setvariable variable=DestPlnUser;]$env:TESTPIPELINEUSER"
    Write-Host "##vso[task.setvariable variable=DestPlnUserPassword;isSecret=true]$env:TESTPIPELINEUSERPASSWORD"

    Write-Host "##vso[task.setvariable variable=DestATServer;]$env:TESTATSERVER"
    Write-Host "##vso[task.setvariable variable=DestATDatabase;]$env:TESTATDATABASE"
    Write-Host "##vso[task.setvariable variable=DestATUser;]$env:TESTATUSER"

    Write-Host "##vso[task.setvariable variable=DestData;]$env:TESTDATA"
    Write-Host "##vso[task.setvariable variable=DestIndex;]$env:TESTINDEX"
    Write-Host "##vso[task.setvariable variable=DestLog;]$env:TESTLOG"

    Write-Host "##vso[task.setvariable variable=DestATData;]$env:TESTATDATA"
    Write-Host "##vso[task.setvariable variable=DestATIndex;]$env:TESTATINDEX"
    Write-Host "##vso[task.setvariable variable=DestATLog;]$env:TESTATLOG"

    # Post-restore vars
    Write-Host "##vso[task.setvariable variable=DestLogins;]$env:TESTDBLOGINS"
}
elseif ($env:REBUILDENVIRONMENT -eq 'test2') {
    Write-Host "Setting environment vars for test2 rebuild"

    # Restore vars
    Write-Host "##vso[task.setvariable variable=DestServer;]$env:TEST2SERVER"
    Write-Host "##vso[task.setvariable variable=DestDatabase;]$env:TEST2DATABASE"
    Write-Host "##vso[task.setvariable variable=DestPlnUser;]$env:TEST2PIPELINEUSER"
    Write-Host "##vso[task.setvariable variable=DestPlnUserPassword;isSecret=true]$env:TEST2PIPELINEUSERPASSWORD"

    Write-Host "##vso[task.setvariable variable=DestATServer;]$env:TEST2ATSERVER"
    Write-Host "##vso[task.setvariable variable=DestATDatabase;]$env:TEST2ATDATABASE"
    Write-Host "##vso[task.setvariable variable=DestATUser;]$env:TEST2ATUSER"

    Write-Host "##vso[task.setvariable variable=DestData;]$env:TEST2DATA"
    Write-Host "##vso[task.setvariable variable=DestIndex;]$env:TEST2INDEX"
    Write-Host "##vso[task.setvariable variable=DestLog;]$env:TEST2LOG"

    Write-Host "##vso[task.setvariable variable=DestATData;]$env:TEST2ATDATA"
    Write-Host "##vso[task.setvariable variable=DestATIndex;]$env:TEST2ATINDEX"
    Write-Host "##vso[task.setvariable variable=DestATLog;]$env:TEST2ATLOG"

    # Post-restore vars
    Write-Host "##vso[task.setvariable variable=DestLogins;]$env:TEST2DBLOGINS"
}
elseif ($env:REBUILDENVIRONMENT -eq 'training') {
    Write-Host "Setting environment vars for training rebuild"

    # Restore vars
    Write-Host "##vso[task.setvariable variable=DestServer;]$env:TRNGSERVER"
    Write-Host "##vso[task.setvariable variable=DestDatabase;]$env:TRNGDATABASE"
    Write-Host "##vso[task.setvariable variable=DestPlnUser;]$env:TRNGPIPELINEUSER"
    Write-Host "##vso[task.setvariable variable=DestPlnUserPassword;isSecret=true]$env:TRNGPIPELINEUSERPASSWORD"

    Write-Host "##vso[task.setvariable variable=DestData;]$env:TRNGDATA"
    Write-Host "##vso[task.setvariable variable=DestIndex;]$env:TRNGINDEX"
    Write-Host "##vso[task.setvariable variable=DestLog;]$env:TRNGLOG"

    # Post-restore vars
    Write-Host "##vso[task.setvariable variable=DestLogins;]$env:TRNGDBLOGINS"
}
else {
    Write-Error -Message "Invalid rebuild environment: $($env:REBUILDENVIRONMENT)" -ErrorAction Stop
}