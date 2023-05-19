Set-Alias -Name k -Value kubectl -Description 'Kubernetes kubectl shorthand'
Set-Alias -Name dn -Value dotnet -Description '.NET dotnet shorthand'
Set-Alias -Name sk -Value skaffold -Description 'Skaffold skaffold shorthand'
# Usage: rfc -c componentName (will be capitalized)
Set-Alias -Name rfc -Value New-Rfc-WithPath -Description 'React functional component'
# Usage: rffc -c componentName (will be capitalized)
Set-Alias -Name rffc -Value New-Rffc-WithPath -Description 'React functional component with filename'


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

function New-Rfc-WithPath {
  param ([string] $ComponentName)

  New-React-Fc -c $ComponentName -WithSrc $true -WithComp $true
}

function New-Rffc-WithPath {
  param ([string] $ComponentName)

  New-React-Ffc -c $ComponentName -WithSrc $true -WithComp $true
}


function New-React-Fc {
  param (
    [string]$ComponentName,
    [bool]$WithSrc = $false,
    [bool]$WithComp = $false
    )

    $normalized = Normalize-ComponentName -ComponentName $ComponentName -WithSrc $WithSrc -WithComp $WithComp

    New-Files -DirectoryName $normalized -Files "index.tsx", "style.module.scss"
}

function New-React-Ffc {
  param (
    [string]$ComponentName
    )

    $normalized = Normalize-ComponentName -ComponentName $ComponentName -WithSrc $WithSrc -WithComp $WithComp
    $compFile = $normalized + ".tsx"

    New-Files -DirectoryName $normalized -Files $compFile, "index.ts", "style.module.scss"
}


# Presets

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Utils
function Normalize-ComponentName {
  param (
    [string]$ComponentName,
    [bool]$WithSrc = $false,
    [bool]$WithComp = $false
    )


    $normalized = Capitalize-FirstLetter -S $ComponentName

  if ($WithComp) {
      $normalized = 'components/' + $normalized
    }

    if ($WithSrc) {
      $normalized = 'src/' + $normalized
    }

    return $normalized
}

function Capitalize-FirstLetter {
    param (
        [string]$String
    )

    $firstChar = $String.Substring(0, 1).ToUpper()
    $capitalizedString = $firstChar + $String.Substring(1)
    return $capitalizedString
}