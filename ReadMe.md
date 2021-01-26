# Jira as  container on openshift 4.x

Install jira with installer as described here:

https://confluence.atlassian.com/adminjiraserver/installing-jira-applications-on-linux-938846841.html


zip installation in file 

	 atlassian-installed.zip

and place it the directory close to Dockerfile

build Docker container with script:

	 build-docker-local.sh


I used podman but you can use docker as well


## deploy on OpenShift 



        oc new-project jira
    

        # set registry endpoint
        export REGISTRY_URL=default-route-openshift-image-registry.apps.ocp-cluster-1.rhlab.ch

        # login to registry first
        podman login -u $(oc whoami) -p $(oc whoami -t) $REGISTRY_URL --tls-verify=false

        # push your container to internal registry

        podman push --tls-verify=false $REGISTRY_URL/jira/niko-jira:latest


        


