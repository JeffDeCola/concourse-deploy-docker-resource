#!/bin/sh
# concourse-deploy-docker-resource test-concourse-deploy-docker-resource.sh

echo " "

if [ "$1" = "-debug" ]
then
    echo "test-concourse-deploy-docker-resource.sh -debug (START)"
    # set -e causes the shell to exit if any subcommand or pipeline returns a non-zero status. Needed for concourse.
    # set -x enables a mode of the shell where all executed commands are printed to the terminal.
    set -e -x
    echo " "
else
    echo "test-concourse-deploy-docker-resource.sh (START)"
    # set -e causes the shell to exit if any subcommand or pipeline returns a non-zero status.  Needed for concourse.
    set -e
    echo " "
fi

echo "GOAL ----------------------------------------------------------------------------------"
echo " "

echo "To do something to the STUFF you got"
echo " "

echo "CHECK THINGS --------------------------------------------------------------------------"
echo " "

echo "At start, you should be in a /tmp/build/xxxxx directory with two folders:"
echo "   /concourse-deploy-docker-resource"
# echo "   /concourse-deploy-docker-resource-updated (created in task-build-push.yml task file)"
echo " "

echo "pwd is"
pwd 
echo ""

echo "ls directory"
ls -lat 
echo ""

echo "DO SOMETHING -------------------------------------------------------------------------"
echo " "

echo "cd test-resource-deploy-docker"
cd test-resource-deploy-docker
echo "List whats in the current directory"
ls -la
echo " "

echo "cat get_fetch.json"
cat get_fetch.json
echo " "

echo "Add a file for fun"
echo 'This is a test' > job-test-concourse-deploy-docker-resource.txt
echo " "

echo "ls directory"
ls -lat 
echo ""

echo "test-concourse-deploy-docker-resource.sh (END)"
echo " "
