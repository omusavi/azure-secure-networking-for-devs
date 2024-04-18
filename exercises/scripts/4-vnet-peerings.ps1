#!/usr/bin/env pwsh

param(
    [string]$TeamName = $env:TEAM_NAME
)

if ($TeamName.Length -lt 2) {
    Write-Error "Invalid argument: Team name missing or too short (must be at least 2 characters long)"
    exit 1
}

$ResourceGroupNameHub = $env:ASNFD_RESOURCE_GROUP_NAME_HUB
$VnetNameHub = $env:ASNFD_VNET_NAME_HUB
$ResourceGroupNames = @($env:ASNFD_RESOURCE_GROUP_NAME_EU, $env:ASNFD_RESOURCE_GROUP_NAME_US)
$VnetNames = @($env:ASNFD_VNET_NAME_EU, $env:ASNFD_VNET_NAME_US)

Write-Output "`nPeering virtual networks to using the hub and spoke model..."

for ($i = 0; $i -lt 2; $i++) {
    .\subscripts\4-1-vnet-peerings.ps1 `
        -ResourceGroupName1 $ResourceGroupNameHub `
        -VnetName1 $VnetNameHub `
        -ResourceGroupName2 $ResourceGroupNames[$i] `
        -VnetName2 $VnetNames[$i]
}
