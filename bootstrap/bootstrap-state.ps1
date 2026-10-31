# bootstrap-state.ps1
# Creates the Azure Storage account + container that hold Terraform state for this repo.
# Run once per subscription. Safe to re-run: az create commands update what already exists.
#
# Why az CLI and not Terraform: Terraform needs somewhere to store state before it can
# create anything, so the state storage has to exist first (chicken-and-egg).

$ErrorActionPreference = "Stop"
Set-Location "C:\Users\shouk\Development\repos\azure-platform-basic-lab\bootstrap"

$location  = "canadacentral"
$rg        = "rg-tfstate-ksa"
$sa        = "sttfstateksa01"   # globally unique; change the digits if taken (and in every backend.tf)
$container = "tfstate"

function Assert-Az([string]$step) {
    if ($LASTEXITCODE -ne 0) { throw "az failed at: $step" }
}

Write-Host "Subscription in use (check this before anything is created):"
az account show --query "{name:name, id:id}" -o table; Assert-Az "account show"

Write-Host "1/5 Resource group $rg (kept separate - never destroyed with app resources)"
az group create --name $rg --location $location -o none; Assert-Az "group create"

Write-Host "2/5 Storage account $sa (TLS 1.2, no public blob access - state can contain secrets)"
az storage account create --name $sa --resource-group $rg --location $location `
    --sku Standard_LRS --kind StorageV2 `
    --min-tls-version TLS1_2 --allow-blob-public-access false -o none
Assert-Az "storage account create"

Write-Host "3/5 Blob versioning + 7-day soft delete (undo button for the state file)"
az storage account blob-service-properties update --account-name $sa --resource-group $rg `
    --enable-versioning true --enable-delete-retention true --delete-retention-days 7 -o none
Assert-Az "blob-service-properties update"

Write-Host "4/5 Container $container (via ARM, so no data-plane permission needed yet)"
az storage container-rm create --storage-account $sa --resource-group $rg --name $container -o none
Assert-Az "container-rm create"

Write-Host "5/5 Storage Blob Data Contributor for the signed-in user (backend uses Entra auth, not keys)"
$saId = az storage account show --name $sa --resource-group $rg --query id -o tsv; Assert-Az "storage account show"
$me   = az ad signed-in-user show --query id -o tsv; Assert-Az "signed-in-user show"
az role assignment create --assignee-object-id $me --assignee-principal-type User `
    --role "Storage Blob Data Contributor" --scope $saId -o none
Assert-Az "role assignment create"

Write-Host ""
Write-Host "Done. State storage: $sa / $container in $rg"
Write-Host "Role assignments take 1-3 minutes. If terraform init returns 403, wait and retry."
Write-Host "For GitHub Actions, the pipeline identity needs the same data role (scoped to the container)."
