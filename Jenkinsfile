pipeline {
  options {
    disableConcurrentBuilds()
  }
  agent {
    kubernetes {
      label "module-1"
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    application: "module-1"
  ci: true
spec:
  containers:
  - name: docker-dind
    image: gcr.io/cloudwms-195710/docker-in-docker-with-git-gcloud
    command:  ["sh"]
    args: ["-c","dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock "]
    tty: true 
    securityContext:
      privileged: true
    
  - name: kubectl
    image: gcr.io/cloudwms-195710/gcloud-kubectl-git
    imagePullPolicy: Always
    env:
    - name: SECRET_USERNAME
      valueFrom:
        secretKeyRef:
          name: mysecret
          key: kubernetes-username
    - name: SECRET_PASSWORD
      valueFrom:
        secretKeyRef:
          name: mysecret
          key: kubernetes-password
    tty: true
    securityContext:
      privileged: true
  imagePullSecrets: 
  - name: gcr-json-key
 
 """
    }
  }
  environment {
    DEPLOY_NAMESPACE = "cloudwms-dev"
  }
  stages {
	 stage('building discovery-service') {
    steps {
        
  container('docker-dind') {
      sh '''
        TAG_NAME=$(git rev-parse HEAD)
  IMAGE_TAG=${TAG_NAME:0:7}

        docker login -u _json_key -p "$(cat /home/first.json)" https://gcr.io
                            
        docker build -t  discovery-service --file  discovery-service-dockerfile .
        docker tag  discovery-service  gcr.io/cloudwms-195710/discovery-service:$IMAGE_TAG
        docker push gcr.io/cloudwms-195710/discovery-service:$IMAGE_TAG
        
         '''
            
        }
        
     }
     }
stage('deploying and exposing discovery service') {
 steps {
  container('kubectl') {
    sh '''
    
    TAG_NAME=$(git rev-parse HEAD)
  IMAGE_TAG=${TAG_NAME:0:7}
  

  
        kubectl config set-credentials cloudwmsuser --username=$SECRET_USERNAME --password=$SECRET_PASSWORD

        kubectl config set-cluster cloudwmscluster --insecure-skip-tls-verify=true --server=https://35.239.186.113

        kubectl config set-context cloudwmscontext --user=cloudwmsuser --namespace=cloudwms-dev --cluster=cloudwmscluster

        kubectl config use-context cloudwmscontext
 
        kubectl get pods -n cloudwms-dev

        source pod-deployment.sh; application_deployment gcr.io/cloudwms-195710/discovery-service cloudwms-discovery-service 1 $IMAGE_TAG 8082

        source pod-service.sh; application_service   cloudwms-discovery-service 30001  30001
        
        sleep 5
        
       
        
        source pod-status.sh; pod_status  cloudwms-discovery-service 
      
        '''
  }
  }
  }
  

	    






  


             
                          
 
}
}
