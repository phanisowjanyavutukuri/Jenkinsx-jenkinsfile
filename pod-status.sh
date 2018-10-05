function pod_status()
{
local DEPLOYMENT_NAME=${1:?Provide the DEPLOYMENT-NAME}

var=$(kubectl rollout status deploy/$DEPLOYMENT_NAME -n cloudwms-dev)
echo $var
var2="deployment "cloudwms-discovery-service" successfully rolled out"

[ $var = $var2 ] &&  echo "pod is deployed successfully" || kubectl rollout undo deployment/$DEPLOYMENT_NAME --to-revision=1 -n cloudwms-dev

}
