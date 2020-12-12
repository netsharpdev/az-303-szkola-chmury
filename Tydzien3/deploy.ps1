Connect-AzAccount

$rg = 'rg-netsharp-learn-prod'

# Generate a SAS token
$VNetLinkedTemplateUri = "https://raw.githubusercontent.com/netsharpdev/az-303-szkola-chmury/master/Tydzien3/Vnet.json"

$VMLinkedTemplateUri = "https://raw.githubusercontent.com/netsharpdev/az-303-szkola-chmury/master/Tydzien3/vm-create-arm.json"

# Deploy the template
New-AzResourceGroupDeployment `
  -Name 'DeployLinkedTemplate' `
  -ResourceGroupName $rg `
  -TemplateFile '.\tydzien3.json' `
  -VnetTemplateUrl $VNetLinkedTemplateUri `
  -VmTemplateUrl $VMLinkedTemplateUri `
  -EnvironmentName 'dev' `
  -AdminUserVm 'NetsharpAdmin' `
  -AdminPasswordVm 'Netsharp123!'