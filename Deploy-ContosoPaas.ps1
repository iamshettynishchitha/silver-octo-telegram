### Define variables
{
$resourceGrouoLocation = 'East US'
$resourceGroupName = 'contoso-paas'
$resourceDeploymentName = 'contoso-paas-deployment'
$templatePath = $PWD
$templateFile = 'ContosoPaas.json'
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
