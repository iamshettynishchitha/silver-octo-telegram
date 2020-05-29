### Define variables
{
$location = 'East US'
$resourceGroupName = 'contose-iaas'
$resourceDeploymentName = 'contose-iaas-deployment'
$templatePath = $PWD
$templateFile = 'ContoseIaas.json'
$template = Join-Path $templatePath $templateFile 
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
