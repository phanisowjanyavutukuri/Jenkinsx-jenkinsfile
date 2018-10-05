function pod_status()
{

local DEPLOYMENT_NAME=${1:?Provide the DEPLOYMENT-NAME}

var=$(kubectl rollout status deploy/$DEPLOYMENT_NAME  -n cloudwms-dev)
echo $var
var2="deployment \"$DEPLOYMENT_NAME\" successfully rolled out"
echo "var2"




if [ "$var" == "$var2" ] 
then
      echo "pod is deployed successfully"
else
     kubectl rollout undo deployment/$DEPLOYMENT_NAME --to-revision=1 -n cloudwms-dev
fi

}