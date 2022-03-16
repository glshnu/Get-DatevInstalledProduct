# Auslesen der installatierten Produkt Version
# 03/2022 - Thomas Lauer (lauer@glsh.net)
# Github - 

function Get-DatevInstalledProduct 
{  
    param(  
        [parameter(Mandatory = $true)] [string] $server,
        [parameter(Mandatory = $true)] [string] $product
    ) 

    $servername = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\wow6432node\DATEVeG\InstallInfos\DefaultDataServers' -Name "(default)"
    $defaultvolume = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\wow6432node\DATEVeG\InstallInfos\DefaultDataServers\$servername" -Name "DefaultVolume"
    
    [xml]$xmlAttr = Get-Content -Path "$defaultvolume\DATEV\DATEN\INSTMAN\ProductList\$server.xml";
    $xmlAttr.PRODUKTE.PRODUKT | ForEach-Object  {
        if($_.name -match $product)
        {
            Write-host ">> " $_.name $_.INFOVERSION

            [pscustomobject]@{
               Product = $_.name
               Version = $_.INFOVERSION
            }
        }
    }
}

$productlist = Get-InstalledProduct -server DENU-SR01 -product Familienrecht

# write-host $productlist[0].Version
