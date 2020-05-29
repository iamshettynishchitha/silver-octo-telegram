Login-AzureRmAccount

$subscriptionId = Get-AzureRmSubscription | select id
$adTenant = Get-AzureRmSubscription | select TenantId`

$result = Get-AADAppoAuthToken -ClientID <AzureAD APPLICATION ID> -ClientSecret <ClientSecret> -TenantId $adTenant
$AuthKey = "Bearer " + ($result.access_token)

$authHeader = @{
    'Content-Type'  = 'application/json'
    'Accept'        = 'application/json'
    'Authorization' = $AuthKey
}

$apiVersion = "2015-01-01"
$Groups = @()
foreach ($rg in $ResourceGroups) 
{
    $ResourceGroupUri = "https://management.azure.com/subscriptions/$subscriptionID/resourceGroups/$rg/resources?api-version=$APIVersion"
    $res = (Invoke-RestMethod -Uri $ResourceGroupUri -Method GET -Headers $authHeader).value

 

    #Create array of all resources
    $resources = @{}
    $resources.Add($rg, $res)

 

    #Add all resource groups and their resources to a hash table
    $Groups += $resources
}