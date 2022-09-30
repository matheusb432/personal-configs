Set-Alias -Name k -Value kubectl -Description 'Kubernetes kubectl shorthand'
Set-Alias -Name dn -Value dotnet -Description '.NET dotnet shorthand'

function prompt {
  $p = Split-Path -leaf -path (Get-Location)
  "~ $p> "
}