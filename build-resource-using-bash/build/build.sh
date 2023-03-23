#!/bin/sh -e
# concourse-deploy-docker-resource build.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "************************************************************************"
    echo "* build.sh -debug (START) **********************************************"
    echo "************************************************************************"
    # set -x enables a mode of the shell where all executed commands
    # are printed to the terminal.
    set -x
    echo " "
else
    echo "************************************************************************"
    echo "* build.sh (START) *****************************************************"
    echo "************************************************************************"
    echo " "
fi

echo "cd to where go code is"
echo "cd .."
cd ..
echo " " 

echo "Build your docker image using Dockerfile"
echo "NOTE: The binary is built using this step"
echo "docker build -f build/Dockerfile -t jeffdecola/concourse-deploy-docker-resource ."
docker build -f build/Dockerfile -t jeffdecola/concourse-deploy-docker-resource .
echo " "

echo "Check Docker Image size"
echo "docker images jeffdecola/concourse-deploy-docker-resource:latest"
docker images jeffdecola/concourse-deploy-docker-resource:latest
echo " "

echo "Useful commands:"
echo "     docker run --name concourse-deploy-docker-resource -dit jeffdecola/concourse-deploy-docker-resource"
echo "     docker exec -i -t concourse-deploy-docker-resource /bin/bash"
echo "     docker logs concourse-deploy-docker-resource"
echo " "

echo "************************************************************************"
echo "* build.sh (END) *******************************************************"
echo "************************************************************************"
echo " "
