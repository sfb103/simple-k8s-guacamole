# simple-k8s-guacamole
A simple kubernetes deployment for a guacamole remote access gateway.

This project works well for a simple deployment, such as a DIY homelab setup, where you'd like to provision a simple remote access gateway on a kubernetes cluster.  This deploys [Appache Guacamole](https://guacamole.apache.org/) which enables remote access to machines on your home network.  By running this remote access gateway in containers, it offers better isolation from it's host at the file system and network levels.  And by running it on kubernetes, it provides declartative deployments and rohbustness features, such as liveness probes.

This guacamole setup has 3 deployments:
- guacamole - The web-client frontend
- guacd - The server backend
- guac-postgres - A postgres database instance to hold user and connection information

Before first use, the postgres database must be seeded.  This can be done simply by running the init.sh script:
```
./init.sh
```
**Note**, this script and the guac-postgres deployment currenlty assumes the persistent data for postgres is simply kept in a ```/volumes/guac-postgres``` host directory.
 
Then, to provision the guacamole deployments on the kubernetes cluster, simply:
```
kubectl apply -f simple-k8s-guacamole.yaml
```
**Note**, The guacamole web-client is currently explosed through a cluster nodePort: 9080

Once each guacamole pod is ready on the cluster, you can navigate to the web-client using the node-port specified above.  Once the web-client is accessed, follow the documentation on the [Appache Guacamole](https://guacamole.apache.org/) site to setup new users and connections.
