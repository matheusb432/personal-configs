Set-Alias -Name k -Value kubectl -Description 'Kubernetes kubectl shorthand'
Set-Alias -Name dn -Value dotnet -Description '.NET dotnet shorthand'
Set-Alias -Name sk -Value skaffold -Description 'Skaffold skaffold shorthand'
# Usage: rfc -c componentName (will be capitalized)
Set-Alias -Name rfc -Value New-React-Fc -Description 'React functional component'
# Usage: rffc -c componentName (will be capitalized)
Set-Alias -Name rffc -Value New-React-Ffc -Description 'React functional component with filename'
 


function prompt {
  $p = Split-Path -leaf -path (Get-Location)
  "~ $p> "
}

function New-Files {
  param (
      [string]$DirectoryName,
      [string[]]$Files
  )

  New-Item -ItemType Directory -Path $DirectoryName | ForEach-Object {
      foreach ($file in $Files) {
          New-Item -ItemType File -Path $_ -Name $file
      }
  }
}


function New-React-Fc {
  param (
    [string]$ComponentName
    )

    $firstChar = $ComponentName.Substring(0, 1).ToUpper()
    $capitalizedString = $firstChar + $ComponentName.Substring(1)


    New-Files -DirectoryName $capitalizedString -Files "index.tsx", "style.module.scss"
}

function New-React-Ffc {
  param (
    [string]$ComponentName
    )

    $firstChar = $ComponentName.Substring(0, 1).ToUpper()
    $capitalizedString = $firstChar + $ComponentName.Substring(1)
    $compFile = $capitalizedString + ".tsx"

    New-Files -DirectoryName $capitalizedString -Files $compFile, "index.ts", "style.module.scss"
}


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
