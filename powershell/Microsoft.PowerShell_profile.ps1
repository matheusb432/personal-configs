Set-Alias -Name k -Value kubectl -Description 'Kubernetes kubectl shorthand'
Set-Alias -Name dn -Value dotnet -Description '.NET dotnet shorthand'
Set-Alias -Name sk -Value skaffold -Description 'Skaffold skaffold shorthand'

# Scaffolds

# Usage: rfc -c name, name2 (will be capitalized)
Set-Alias -Name rfc -Value New-Rfc-WithPath -Description 'React functional component'
# Usage: rffc -c name, name2 (will be capitalized)
Set-Alias -Name rffc -Value New-Rffc-WithPath -Description 'React functional component with filename'
# Usage: tsf -f file-name, file-name2
Set-Alias -Name tsf -Value TsFile-WithTest -Description 'Create a typescript file with a test in /__tests__'


function prompt {
  $p = Split-Path -leaf -path (Get-Location)
  "~ $p> "
}

function New-Files {
  param (
      [string]$DirectoryName,
      [string[]]$Files
  )

      if (!(Test-Path $DirectoryName)) {
        New-Item -ItemType Directory -Path $DirectoryName
      }

      foreach ($file in $Files) {
        if (!(Test-Path $DirectoryName)) {
          New-Item -ItemType Directory -Path $DirectoryName
        }
        
        New-Item -ItemType File -Path $DirectoryName -Name $file
      }
}

function TsFile-WithTest {
  param (
      [string[]]$Files
  )

  $testDir = '__tests__'

  if (!(Test-Path $testDir)) {
      New-Item -ItemType Directory -Path $testDir
  }

  foreach ($file in $Files) {
      $fileName = $file + '.ts'
      $testFileName = $file + '.test.ts'

      New-Item -ItemType File -Path $testDir -Name $testFileName
      New-Item -ItemType File -Name $fileName
  }
}

function New-Rfc-WithPath {
  param ([string[]] $ComponentNames, $Path = $true)



  foreach ($componentName in $ComponentNames) {
    New-React-Fc -c $componentName -WithSrc $Path -WithComp $Path
  }
}

function New-Rffc-WithPath {
  param (
    [string[]] $ComponentNames,
    [bool]$Test = $false,
    [bool]$Path = $true
  )

  foreach ($componentName in $ComponentNames) {
    New-React-Ffc -c $componentName -WithSrc $Path -WithComp $Path -WithTest $Test
  }
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
    [string]$ComponentName,
    [bool]$WithSrc = $false,
    [bool]$WithComp = $false,
    [bool]$WithTest = $false
    )

    $path = Normalize-ComponentName -ComponentName $ComponentName -WithSrc $WithSrc -WithComp $WithComp
    $capitalized = Capitalize-FirstLetter -S $ComponentName
    $tsxFile = $capitalized + '.tsx'

    if ($WithTest) {
      $testFile = $capitalized + '.test.tsx'
      New-Files -DirectoryName $path -Files $tsxFile, $testFile, "index.ts", "style.module.scss"
    } else {
      New-Files -DirectoryName $path -Files $tsxFile, "index.ts", "style.module.scss"
    }

    $indexPath = $path + '/index.ts'
    $indexContent = 'export * from ' +"'./"+ $capitalized + "';"

    Set-Content -Path $indexPath -Value $indexContent
}

function Change-React-Folder-Structure {
  param (
    [string]$DirectoryName
    )

    Rename-IndexFiles -p $DirectoryName
    Add-IndexFiles -p $DirectoryName
}


# Presets

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

# Function to rename any index.tsx files in any child directory of a given directory to {childDirectory}.tsx
function Rename-IndexFiles {
    param (
        [string]$ParentDirectory
    )

    $childDirectories = Get-ChildItem -Path $ParentDirectory -Directory

    foreach ($childDirectory in $childDirectories) {
        $indexPath = Join-Path -Path $childDirectory.FullName -ChildPath "index.tsx"
        $newPath = Join-Path -Path $childDirectory.FullName -ChildPath "$($childDirectory.Name).tsx"

        if (Test-Path -Path $indexPath) {
            Rename-Item -Path $indexPath -NewName $newPath
            Write-Host "Renamed $indexPath to $newPath"
        }
    }
}

# Function that adds a 'index.ts' file in every subdirectory of a given directory with export
function Add-IndexFiles {
  param (
    [string]$ParentDirectory
  )

  $directories = Get-ChildItem -Path $ParentDirectory -Directory

  foreach ($directory in $directories) {
    $indexFile = $directory.FullName + '\index.ts'
    if (!(Test-Path $indexFile)) {
      New-Item -ItemType File -Path $directory.FullName -Name 'index.ts'

      $indexContent = 'export * from ' +"'./"+ $directory + "';"

      Set-Content -Path $indexFile -Value $indexContent
    }
  }
}