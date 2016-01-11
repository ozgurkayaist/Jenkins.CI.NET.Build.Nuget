
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
- Enable nuget package restore
- Add Octopack to solution (There is no need for non-IIS solutions)
- Deploy.ps1
- Deploy.cmd (MSBuild) (There is no need for non-IIS solutions)
- YourcsProjectName.nuspec

**C.Create a Jenkins Job** 
- Source Code Management
 -Build Triggers
- Build Environment (Create a formatted version number)
- Build (Change Assembly Version) (For files like dll, exe.. versioning)

 -Build (Build a Visual Studio project or solution using MSBuild):
 Set MSBuild
 Build File $WORKSPACE\Yourproject.sln

Command Line Arguments:
 /t:Rebuild /p:DebugSymbols=false /p:DebugType=None /p:IsAutoBuild=True /p:CreatePackageOnPublish=true /p:Configuration=Release;DeployOnBuild=True;PackageLocation=".\obj\Release\myproject.zip";PackageAsSingleFile=True /p:RunOctoPack=true /p:OctoPackPackageVersion=%VERSION% /p:OctoPackPublishPackageToHttp=http://YOUR_OCTOPUSDEPLOY_URL/nuget/packages /p:OctoPackPublishApiKey=YOUR_OCTOPUSDEPLOY_APIKEY
 
 -Build(Execute Windows batch command) (Run unit tests, call OctopusDeploy API,..)
 call "C:\Scripts\JenkinsOctopack.bat" YourProjectName %VERSION% %BUILD_NUMBER% %JOB_NAME%
 
- Post Build(Notifications like Email)

**D.Check the build and package**

- Jenkins Console Log
- Nuget Package Explorer