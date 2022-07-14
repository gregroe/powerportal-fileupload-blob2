## A Solution architecture that shows how external users can securely register on Power Apps Portal  to upload Large Gb Files to Azure storage by either the Azure Storage SFTP Service for very large files or a Static JavaScript Web App.

# * Why is this solution needed?  What problem does it solve?
   * Background
   * Azure Cloud Solutions can be created on a customer secure vnet on a AAD tenant that is a secure extension of their organizational network.
   * There is the need for said Customers need to obtain large Gb files from their external end partners/customers that are not part of their organizational AAD tenant. 
   * They need to keep securely approve and keep track of who uploaded what file.
![image](https://user-images.githubusercontent.com/32680536/179013485-7e7c8df5-4695-4ec2-9632-85bcefdcb386.png)

 
![Alt Image text](/architecture.png?raw=true "Architecture")
