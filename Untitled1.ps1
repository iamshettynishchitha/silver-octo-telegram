#Loop through each reasource group and get all resources.
#Add everything to a hash table
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
#get the health of the whole resource group
# Add each health status to a hashtable before output a complete table with all resource groups and their resource health
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