function pod_status()
{

local DEPLOYMENT_NAME="nginx-deployment"

var=$(kubectl rollout status deploy/$DEPLOYMENT_NAME )
echo $var
var2="deployment \"nginx-deployment\" successfully rolled out"
echo "var2"




if [ "$var" == "$var2" ] 
then
      echo "pod is deployed successfully"
else
     kubectl rollout undo deployment/$DEPLOYMENT_NAME --to-revision=1
fi

}