$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $root

$profile = Get-Content -Raw metadata/property-map.json | ConvertFrom-Json
$w = $profile.weights
$thresholds = $profile.thresholds

function Get-Score($row) {
  return ([int]$row.signal * [int]$w.signal) + ([int]$row.slack * [int]$w.slack) + ([int]$row.confidence * [int]$w.confidence) - ([int]$row.drag * [int]$w.drag)
}

function Get-Lane($score) {
  if ($score -ge [int]$thresholds.ship) { return "ship" }
  if ($score -ge [int]$thresholds.watch) { return "watch" }
  return "hold"
}

$matrix = Import-Csv fixtures/golden/lane-matrix.csv
if ($matrix.Count -ne 27) { throw "watch-plat-terraform-forge lane matrix count changed" }
foreach ($row in $matrix) {
  $score = Get-Score $row
  if ($score -ne [int]$row.score) { throw "watch-plat-terraform-forge matrix score mismatch for $($row.id)" }
  if ((Get-Lane $score) -ne $row.lane) { throw "watch-plat-terraform-forge matrix lane mismatch for $($row.id)" }
}

$boundary = Get-Content fixtures/fuzz/boundary-cases.jsonl | ForEach-Object { $_ | ConvertFrom-Json }
if (@($boundary).Count -lt 20) { throw "watch-plat-terraform-forge boundary fixture too small" }
foreach ($row in $boundary) {
  $score = Get-Score $row
  if ($score -ne [int]$row.score) { throw "watch-plat-terraform-forge boundary score mismatch for $($row.id)" }
  if ((Get-Lane $score) -ne $row.lane) { throw "watch-plat-terraform-forge boundary lane mismatch for $($row.id)" }
}

Write-Host "watch-plat-terraform-forge golden checks passed"
