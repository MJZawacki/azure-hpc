#!/bin/bash
#####################
# Prerequisites
#   1. run 'az login' to login to Azure CLI
#   2. Set up an Azure Ad group to get the role and group ids for the managed app admin
#   3. Have access to a storage account to hold the managed app definition during the creation process
#   4. Edit variables in vars.sh to the names and resource groups that you prefer
#####################
source ./vars.sh

echo 'Getting group info'

roleid=$(az role definition list --name Owner --query [].name --output tsv)
groupid=$(az ad group show --group $adgroup --query objectId --output tsv)

echo 'Creating zip file'
zipfile='AzureHPC.zip'
packageFile='../../'$zipfile
rm -rf $packageFile
#Need windows compatible zip file - using 7zip - unix zip may not work
7z a -r $packageFile ../*
echo 'Uploading to Azure'
az storage blob upload -n AzureHPC.zip -c $managedappcontainer --account-name $storageAccountName --account-key $storageKey -f $packageFile

#Generate SAS key for managed app definition to securely access zip file for one day
expirydate=`date -u --date '1 day' +'%Y-%m-%dT%H:%M:%SZ'`
saskey=`az storage blob generate-sas --permissions r --expiry $expirydate  -n $zipfile -c $managedappcontainer --account-name $storageAccountName --account-key $storageKey -o tsv`

echo 'Creating Managed App Definition'
az managedapp definition create --name $appname --location $apploc --resource-group $apprg --lock-level None --display-name "$appdisplayname" --description "$appdescription" --authorizations "$groupid:$roleid" --package-file-uri https://$storageAccountName.blob.core.windows.net/$managedappcontainer/$zipfile?$saskey
