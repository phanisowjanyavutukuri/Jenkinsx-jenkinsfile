function pod_status()
{
local DEPLOYMENT_NAME=${1:?Provide the DEPLOYMENT-NAME}
local IMAGE_NAME=${2:?Provide the IMAGE_NAME}
var=$(kubectl rollout status deploy/$DEPLOYMENT_NAME)
echo $var
var2="successfully"
if [[ $var =~ $var2 ]]
then
 echo "Pod is deployed successfully"
else
    source rolling-bach.sh; rolling_back_script $DEPLOYMENT_NAME $IMAGE_NAME 
fi
}
