using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)


# Interact with query parameters or the body of the request.
$containername = $Request.Query.ContainerName

$storageAcc = Get-AzStorageAccount -ResourceGroupName "FTP" -Name "fileuploadsgreg"
$ctx = $storageAcc.Context


#check and see if the container already exists
if(Get-AzStorageContainer -Name $containername -Context $ctx -ErrorAction SilentlyContinue)
{
    $body =  "$containername - container already exists"
}
#creat container if it doesn't exist
else
{
    New-AzStorageContainer -Name $containername -Permission Off -Context $ctx
    $body = "$containername - new container created"
}


# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
