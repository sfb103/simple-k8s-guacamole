#!/bin/bash

# Pick the location where the guac-postgres data should be loaded to 
VOLUME=/volumes/guac-postgres

# Get the pod name for guac-postgres. Allows us to attach to it later.
POD=$(/usr/bin/kubectl get pod -l name=guac-postgres -o jsonpath="{.items[0].metadata.name}")

# Grab sudo privledges up front
sudo ls > /dev/null 

# Release the simple-k8s-guacamole deployment
kubectl	delete -f simple-k8s-guacamole.yaml

# Ensure our guac-postgres is finished shutting down before proceeding 
kubectl attach $POD  

# Ensure our volume location exists, and then load our guac-postgres data to it.
sudo mkdir -p $VOLUME
sudo tar xfvz guac-postgres-data.tar.gz -C $VOLUME 

# Re-create the simple-k8s-guacamole deployment
kubectl create -f simple-k8s-guacamole.yaml 
