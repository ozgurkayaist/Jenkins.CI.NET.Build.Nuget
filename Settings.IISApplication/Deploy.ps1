[string[]]$params = @(
			"-setParam:name='IIS Web Application Name',value='" + $iisapplicationname + "'",
			"-skip:Directory=^" + $iisapplicationname + "\\App_Data",
			"-skip:File=.config$",

			)
$msdeployArgs = [string]::join(' ', $params)

	.\obj\Release\Yourcsprojectname.Deploy.cmd /Y /M:localhost ($msdeployArgs) | Write-Output

