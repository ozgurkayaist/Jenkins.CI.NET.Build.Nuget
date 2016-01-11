
## Build and Nuget your .NET solutions with Jenkins ##


**A. Required Jenkins Plugins** 
- Version Number Plugin
- Change Assembly Version
- MSBuild Plugin
- MSTestRunner Plugin
- NUnit Plugin
- (optional) Team Foundation Server Plugin
- (optional) Git Plugin
- (optional) Visual Studio Code Metrics Plugin
- (optional) Nuget Plugin

**B.Prerequisites**
- Enable nuget package restore for your solution
- Add Octopack to solution from Nuget gallery (There is no need for non-IIS solutions)
- Add Deploy.ps1
- Add YourcsProjectName.nuspec
- Add Deploy.cmd (MSBuild) (There is no need for non-IIS solutions)

**C.Create a Jenkins Job** 
- Source Code Management
 -Set Build Triggers
- Build Environment (Create a formatted version number)
- Build (Change Assembly Version):For files versioning like dll, exe.. 
- Build (Build a Visual Studio project or solution using MSBuild): 

Set MSBuild parameters

	 $WORKSPACE\Yourproject.sln

Command Line Arguments for IIS applications:

	/t:Rebuild /p:DebugSymbols=false /p:DebugType=None /p:IsAutoBuild=True /p:CreatePackageOnPublish=true /p:Configuration=Release;DeployOnBuild=True;PackageLocation=".\obj\Release\myproject.zip";PackageAsSingleFile=True /p:RunOctoPack=true /p:OctoPackPackageVersion=%VERSION% /p:OctoPackPublishPackageToHttp=http://YOUR_OCTOPUSDEPLOY_URL/nuget/packages /p:OctoPackPublishApiKey=YOUR_OCTOPUSDEPLOY_APIKEY

 Command Line Arguments for non-IIS applications:
 
	/t:Rebuild /p:OutDir="$WORKSPACE\Binaries\Release\YourWCFService\\" /p:Configuration=Release /p:Platform="Any CPU"
 
- Build(Execute Windows batch command) (Run unit tests, call OctopusDeploy API,..)
 

		"Create Octopus Release for IIS apps."
		call "C:\Scripts\JenkinsOctopack.bat" YourProjectName %VERSION% %BUILD_NUMBER% %JOB_NAME%

- "Nuget Pack and Push to Octopus"

		call C:\Scripts\JenkinsciPack.bat "%WORKSPACE%\UserService.WindowsService\YourService.nuspec" %VERSION%
		call C:\Scripts\JenkinsciPush.bat TY.UserService %VERSION%

 
 
- Post Build(Notifications like Email)

**D.Check the build and package**

- Jenkins Console Log: Check Your commands had worked
- Install Nuget Package Explorer to your Nuget Feed Server. Explore the package files.