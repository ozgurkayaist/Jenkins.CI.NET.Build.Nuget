Build and Nuget your .NET solutions with Jenkins


A. Required Jenkins Plugins Version Number Plugin Change Assembly Version MSBuild Plugin MSTestRunner Plugin NUnit Plugin (optional) Team Foundation Server Plugin (optional) Git Plugin (optional) Visual Studio Code Metrics Plugin (optional) Nuget Plugin

B.Prerequisites

Enable nuget package restore Add Octopack to your solution Deploy.ps1 Deploy.cmd (MSDeploy) YourcsProjectName.nuspec

C.Create a Jenkins Job Source Code Management Build Triggers Build Environment (Create a formatted version number) Build (Change Assembly Version) Build(Execute Windows batch command) Build (Build a Visual Studio project or solution using MSBuild) Build(Execute Windows batch command) (Run unit tests, call OctopusDeploy API,..) Post Build(Notifications like Email)

D.Check the build and package

Web Deployment Agent Service OctopusDeploy Tentacle(Agent) Deploy with Octopus