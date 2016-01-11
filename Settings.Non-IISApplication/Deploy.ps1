function getSourcePath
{
	if($OctopusEnvironmentName -ceq 'Development'){$BuildPath = "Release"}
	else{$BuildPath = "Release"}

	return Join-Path (Get-Location).Path $BuildPath;
}

function copyRecursive([string]$sourceFolder, [string]$targetFolder, [string]$regExclude)
{
	if(! $regExclude)
	{
		$regExclude = 'EMPTY_NOTMATCH'
	}

    $sourceRegEx = "^"+[regex]::escape($sourceFolder);
    $sources = gci -path $sourceFolder -r | ? {($_.fullname -replace $sourceRegEx, "") -notmatch $regExclude}

    if($sources)
    {
        foreach($source in $sources)
        {
            $targetFullName = ($source.fullname -replace $sourceRegEx, $targetFolder)
            copy-Item $source.fullname -destination $targetFullName -force
        }
    }
}


if(! $ServiceName)
{
	$ServiceName = $OctopusPackageName
}

if(! $ServiceRoot)
{
	$ServiceRoot = "C:\MyServices"
}

$SourcePath = getSourcePath
$TargetPath = Join-Path $ServiceRoot $ServiceName

if ((Test-Path -path $TargetPath) -ne $True)
{
	New-Item $TargetPath -type directory
}

if(! $ServiceExecutable)
{
	$ServiceExecutable = (Get-ChildItem $SourcePath\*.exe -Name | Select-Object -First 1)
}

$FullPath = (Join-Path $TargetPath $ServiceExecutable)

$Service = Get-WmiObject -Class Win32_Service -Filter ("Name = '" + $ServiceName + "'")

if ($Service)
{
Write-Host "Checking for service " + $ServiceName
$svcpid = (get-wmiobject Win32_Service | where{$_.Name -eq $ServiceName}).ProcessId
Write-Host "Found PID " + $svcpid 

Try
{
	Write-Host "Stopping service"
	Stop-Service $ServiceName
	Start-Sleep -seconds 10
}
Catch
{
	$service = Get-Service -name $ServiceName | Select -Property Status

	if($service.Status -ne "Stopped"){	Start-Sleep -seconds 5 }

	#Check-Service process 
	if($svcpid){
    #still exists?
    $p = get-process -id $svcpid -ErrorAction SilentlyContinue
    Write-Host "Rechecking PID"
	if($p){
			Write-Host "Killing Service"
			Stop-Process $p.Id -force
			  }
		}
}
	
	Write-Host "Updating the service files"
	copyRecursive $SourcePath $TargetPath $exclude
    & "sc.exe" config "$ServiceName" binPath= $FullPath  start= auto | Write-Host
	
	Write-Host "Starting Service"
	Start-Service $ServiceName | Write-Host
}
else
{
	Write-Host "The service will be installed"
	
	& "xcopy.exe" "$SourcePath" "$TargetPath" /D /E /Y | Write-Host		
	
	New-Service -Name $ServiceName -BinaryPathName $FullPath -StartupType Automatic
}
