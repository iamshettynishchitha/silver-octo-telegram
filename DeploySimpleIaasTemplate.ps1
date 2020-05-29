### Define variables
{
$location = 'East US'
$resourceGroupName = 'pluralsight-arm-simple-paas-template'
$resourceDeploymentName = 'pluralsight-arm-paas-template-deployment'
$templatePath = $PWD
$templateFile = 'simplejson.json'
$template = Join-Path $templatePath $templateFile -Resolve
}

### Create Resource Group
{
New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $Location `
    -Verbose -Force
}

### Deploy Resources
{
New-AzureRmResourceGroupDeployment `
    -Name $resourceDeploymentName `
    -ResourceGroupName $resourceGroupName `
    -TemplateFile $template `
    -Verbose -Force
}
