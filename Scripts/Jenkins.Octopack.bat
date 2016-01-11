cd C:\Scripts

Octo.exe create-release --project %1 --version %2 --packageversion %2 --server http://YOUR_OCTOPUS_URL --apiKey YOUR_OCTOPUS_BUILTIN_NUGETFEED_APIKEY --deploymenttimeout=00:30:00 --releaseNotes "%5, Jenkins build [%3], http://YOUR_JENKINSURL:8080/job/%4/%3"