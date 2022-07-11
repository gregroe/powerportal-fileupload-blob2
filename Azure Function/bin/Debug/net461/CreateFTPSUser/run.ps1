using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

#Install-Module -Name Az.Storage -RequiredVersion 4.1.2-preview -AllowPrerelease -AllowClobber

# Interact with query parameters or the body of the request.
$containername = $Request.Query.ContainerName
$username = $Request.Query.username
$resourceGroupName ="FTP"
$storageAccountName = "sftpnewgreg"

$permissionScope = New-AzStorageLocalUserPermissionScope -Permission rw -Service blob -ResourceName $containername

$localuser = Set-AzStorageLocalUser -ResourceGroupName $resourceGroupName -StorageAccountName $storageAccountName -UserName $username -HomeDirectory $containername  -PermissionScope $permissionScope -HasSshPassword $true

#$body = $localuser


# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
