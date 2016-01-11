cd C:\NugetPackages

"C:\Scripts\NuGet.exe" push C:\NugetPackages\%1.%2.nupkg -ApiKey YOUR_OCTOPUS_BUILTIN_NUGETFEED_APIKEY -Source http://YOUR_OCTOPUS_URL/nuget/packages