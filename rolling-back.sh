function rolling-back-script()
{

local DEPLOYMENT-NAME=${1:?Provide the DEPLOYMENT-NAME}
local IMAGE_NAME=${2:?Provide the IMAGE_NAME}


kubectl set image deployments/$DEPLOYMENT-NAME $DEPLOYMENT-NAME=$IMAGE_NAME  -n cloudwms-dev


}
