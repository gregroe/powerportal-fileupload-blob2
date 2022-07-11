using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
#Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$containername = $Request.Query.ContainerName

#Get Storage Account and Create a context object 
 #$ctx = New-AzStorageContext -StorageAccountName "fileuploadsgreg" -UseConnectedAccount
$storageAcc = Get-AzStorageAccount -ResourceGroupName "FTP" -Name "fileuploadsgreg"
$ctx = $storageAcc.Context

#check and see if the container exists
if(Get-AzStorageContainer -Name $containername -Context $ctx -ErrorAction SilentlyContinue)
{
    $StartTime = Get-Date
    $EndTime = $startTime.AddHours(48.0)
    $SASuri = New-AzStorageContainerSASToken -Container $containername -Permission rwd -StartTime $StartTime -ExpiryTime $EndTime -Context $ctx -FullUri
    $body = $SASuri
}

#container does not exist create it first, then create SASuri
else
{
    New-AzStorageContainer -Name $containername -Permission Off -Context $ctx
    $StartTime = Get-Date
    $EndTime = $startTime.AddHours(48.0)
    $SASuri = New-AzStorageContainerSASToken -Container $containername -Permission rwd -StartTime $StartTime -ExpiryTime $EndTime -Context $ctx -FullUri
    $body = $SASuri
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})






