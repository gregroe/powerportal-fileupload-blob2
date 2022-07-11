using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
#$name = $Request.Query.Name
#if (-not $name) {
#    $name = $Request.Body.Name
#}

#$subscription = Set-AzContext -Subscription "6865a616-af4b-4372-95d1-2a17b93cc92f" -Tenant "3f640d2f-d02f-4c43-9814-6e2360b5c693"

$storageaccountinfo = Get-AzStorageAccount -ResourceGroupName "FTP" -Name "fileuploadsgreg"

$body = $storageaccountinfo
#$body = $subscription

#if ($name) {
#    $body = "Hello, $name. This HTTP triggered function executed successfully."
#}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
    
})
