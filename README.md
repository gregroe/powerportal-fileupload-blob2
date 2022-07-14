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

