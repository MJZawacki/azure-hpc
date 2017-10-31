#!/bin/bash
source ./vars.sh

subscriptionid=$(az account show --query id --output tsv)

# replace param in file
sed "s/VMNAME/$vmprefix$counter/g" ../parameters.json > localparams.json

echo 'Creating test managed app'
appid=$(az managedapp definition show -n $appname -g $apprg --query id --output tsv)

managedrgid='/subscriptions/'$subscriptionid'/resourceGroups/'$managedrgcontainer
az group create --location $location --name $managedrg
az managedapp create --name $appinstancename --location $location \
    --kind "ServiceCatalog" --resource-group $managedrg \
    --managedapp-definition-id $appid \
    --managed-rg-id $managedrgid \
    --parameters localparams.json \
    --debug

