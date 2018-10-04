function pod_status()
{
local DEPLOYMENT_NAME=${1:?Provide the DEPLOYMENT-NAME}

var=$(kubectl rollout status deploy/$DEPLOYMENT_NAME)
echo $var
var2="successfully"
if [[ $var =~ $var2 ]]
then
 echo "Pod is deployed successfully"
else
    kubectl rollout undo deployment/$DEPLOYMENT_NAME --to-revision=1
fi
}
