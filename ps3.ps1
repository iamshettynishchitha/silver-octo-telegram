$result = Get-AADAppoAuthToken -ClientID <AzureAD APPLICATION ID> -ClientSecret <ClientSecret> -TenantId "test.no"

$AuthKey = "Bearer " + ($result.access_token)

$authHeader = @{

    'Content-Type'  = 'application/json'

    'Accept'        = 'application/json'

    'Authorization' = $AuthKey

}

$Groups = @()



foreach ($rg in $ResourceGroups) {

    $ResourceGroupUri = "https://management.azure.com/subscriptions/$subscriptionID/resourceGroups/$rg/resources?api-version=$APIVersion"

    $res = (Invoke-RestMethod -Uri $ResourceGroupUri -Method GET -Headers $authHeader).value



    #Create array of all resources

    $resources = @{}

    $resources.Add($rg, $res)



    #Add all resource groups and their resources to a hash table

    $Groups += $resources

}

#get all resource groups within a subscription

$APIVersion = "2017-05-10"
$subscriptionID = "086dd96d-4d57-433b-a47b-1dfbee9563e9"
$RGURI = "https://management.azure.com/subscriptions/$subscriptionID/resourcegroups?api-version=$APIVersion"

$ResourceGroups = (Invoke-RestMethod -Uri $RGuri -Method GET -Headers $authHeader).value.name

$resourceGroupHealth = @{}

foreach ($ResourceGroup in $ResourceGroups) {

    

    #Set resource group name and use it in our url

    $health = Invoke-RestMethod -Uri "https://management.azure.com/subscriptions/$subscriptionID/resourceGroups/$ResourceGroup/Providers/Microsoft.ResourceHealth/availabilityStatuses?api-version=2015-01-01" -Method GET -Headers $authHeader



    $currentHealth = @{}

    $currentHealth = @{

        [string]"$ResourceGroup" = [object]$health

    }

$resourceGroupHealth += $currentHealth  

}

$resourceGroupHealth

#Explore the results

$resourceGroupHealth.item('ResourceGroup').Value.Properties