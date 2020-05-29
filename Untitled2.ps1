$subscription=
$ResourceGroups=Get-AzureRmResourceGroup

$Groups = @()

foreach ($rg in $ResourceGroups) {
    $ResourceGroupUri = "https://management.azure.com/subscriptions/$subscriptionID/resourceGroups/$rg/resources?api-version=$APIVersion"
    $res = (Invoke-RestMethod -Uri $ResourceGroupUri -Method GET -Headers $authHeader).value

    #Create array of all resources
    $resources = @{}
    $resources.Add($rg, $res)
     $Groups += $resources
}