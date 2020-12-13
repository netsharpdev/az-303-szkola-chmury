Connect-AzAccount

$userFilter = "*" + (Get-AzContext).Account.Id.Replace('@','_') + "*"

$user = Get-AzAdUser | ?{$_.UserPrincipalName -like $userFilter}

$rg = 'rg-netsharp-learn-prod'

# Generate a SAS token
$VNetLinkedTemplateUri = "https://raw.githubusercontent.com/netsharpdev/az-303-szkola-chmury/master/Tydzien3/Vnet.json"
$KeyvaultTemplateUrl = "https://raw.githubusercontent.com/netsharpdev/az-303-szkola-chmury/master/Tydzien3/Keyvault.json"
$VMLinkedTemplateUri = "https://raw.githubusercontent.com/netsharpdev/az-303-szkola-chmury/master/Tydzien3/Vm.json"

# Deploy the template
New-AzResourceGroupDeployment `
  -Name 'DeployLinkedTemplate' `
  -ResourceGroupName $rg `
  -TemplateFile '.\tydzien3.json' `
  -VnetTemplateUrl $VNetLinkedTemplateUri `
  -VmTemplateUrl $VMLinkedTemplateUri `
  -KeyvaultTemplateUrl $KeyvaultTemplateUrl `
  -EnvironmentName 'dev' `
  -ObjectIdAdUser $user.Id `
  -AdminUserVm 'NetsharpAdmin' `
  -AdminPasswordVm 'Netsharp123!' `
  -RoleDefinition 'VmStartStopRoleDefinition'