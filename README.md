## A Solution architecture that shows how external users can securely register on Power Apps Portal  to upload Large Gb Files to Azure storage by either the Azure Storage SFTP Service for very large files or a Static JavaScript Web App.

### Why is this solution needed?  What problem does it solve?
      * Azure Cloud Solutions can be created on a customer secure vnet on a AAD tenant that is a secure extension of their organizational network.
      * There is the need for said Customers need to obtain large Gb files from their external end partners/customers that are not part of their organizational AAD tenant. 
      * They need to keep securely approve and keep track of who uploaded what file
### Large GigaByte File Transfers over the Internet with HTTPS or SFTP
      *  Power Apps Portal https website with Dataverse backend has the capability to allow for files uploads via attachments, notes, and/or SharePoint Online integration.  How ever there is currently a maximum file size limitation of 50-125Mb.
      *  Custom single page JavaScript based static Web Apps can be written so that Large Files can be transferred.  How ever the maximum file size allowed with the HTTP protocol is 2Gb.  You can get around this limitation by custom coding your web app to chuck the file into smaller chucks!  This method is not inherenlty reliable. In case of disconnect, retry logic should be built in to the app.
      *  SFTP is a long stading secure and reliable protocol used across the industry to transfer large files from a SFTP client to SFTP Server. You can securely and reliablly trasfer many Gigabytes with SFTP
### Solution -  Power Portal, Dataverse, Power Automate , Azure Functions, and Azure Blob Storage are is used to authenticate external users, create file upload requests, and create credentials to store large Gb files
     * 1 Power Apps Portal is used to register and securely authenticate external users 
     * 2 The user completes a Dataverse based Entity Form requesting to upload a large file. 
     * 3 A user Record is stored in Dataverse. 
     * 4 The new record triggers a Power Automate flow.
     * 5 Secure  credentials for each customer via Azure Function calling the blob api via PowerShell
     * 6 The request is approved by the manager
     * 7 The external customer is emailed the credentials
     * 8 The external customer uploads the Gigabyte files with the credentials provided




    




  


![Alt Image text](/architecture.png?raw=true "Architecture")

### Deployment Instructions
1. Download the soltuion via zip or clone

![Alt Image text](/download.png?raw=true "Architecture")

2. Import the Power App Solution into your Power Apps environment
     2a. From Power Apps Studio go to Solutions Tab. 
     2b. Import solution.  Navigate to your hard drive download location to the solution/Powerapp/Solution/PowerPortalFileUploadviablobSASorSFTP_x.zip
 
3. Create and Import Azure Function App
     3a. In the Azure Portal.. create a new function app.  Create a resource group for everything
     3b. zip deployment from command line using AZ CLI
         - Install the Azure CLI for Windows | Microsoft Docs
         -  Az login
         -  az functionapp deployment source config-zip -g <Resource Group Name> -n <Function App Name>  --src <sourcefile.zip>
     
4.  In the Azure Portal Create 2 Storage Accounts
     - Web File Uploads ---   Storage Account V2(general purpose v2).  Performace Premium
     - SFTP             ---   Storage Account V2(general purpose v2).  Performace Premium 
          -- Enable Hierarchical namespace and SFTP  see https://docs.microsoft.com/en-us/azure/storage/blobs/secure-file-transfer-protocol-support-how-to?tabs=azure-portal
          -- Enable Static Web
          -- in Containers/$web/index.html    copy the contents of UploadFile.html
     
5. Setup CORS for Azure Function
     
X. Set up Managed Identity and RBAC for the Funtion App
     
     4a.  in the azure portal select your Azure Function App
     4b.  on the left panel, select Identity
     4c.   Turn on System assigned Managed Identiy
     
X.  Set up Power Portal Entity Form
 
X.  Set up Power Portal Iframe pointing to the static web app fileupload.html


