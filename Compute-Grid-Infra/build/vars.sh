#!/bin/bash

adgroup='' # Active Directory Group to manage access to Managed Apps
storageAccountName=''
storageKey=''

#App Definition Vars
basename='mzHPC'                        #Base name for app instances
vmprefix='hpc'                          #VM prefix copied to params file
appdisplayname='HPC App'                #Managed App Display Name
apprg='mzManagedApps'                   #Managed App Definition Resouce Group 
apploc='westcentralus'                  #Managed App Definition Location (different from instance location)
appdescription='HPC cluster'            #Managed App Description
managedappcontainer='managedapps'
#App Instance Vars
vmprefix='hpc' 
location='westus2'                      #App Instance Location

appname=$basename'App'                  #Managed App Name
appinstancename=$appname                #App Instance Name
managedrg=$appname                      #App Instance Resource Group (visible to end customer)
managedrgcontainer=$managedrg'internal' #App Instance Internal RG    (visible to administrator)