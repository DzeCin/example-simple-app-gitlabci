pipeline {
  agent {
    kubernetes {
     yamlFile 'k8s/jenkins-pod.yaml'
    }
  }
  environment {

        REPO = 'azureacr1dzenancin.azurecr.io'
        KUBEAPI = 'https://kubernetes.default'
        AZURE_CLIENT_ID = credentials('jenkins-azure-client-id')
        AZURE_CLIENT_SECRET = credentials('jenkins-azure-client-secret')
        AZURE_TENANT_ID = credentials('jenkins-azure-tenant-id')
    }

  stages {

    stage('Build') {
      steps {
       container('node'){// no container directive is needed as the maven container is the default
        sh "npm install"
        sh "ng build --prod --output-path=./build"
        sh "ls"
        }
      }
    }


    stage('Build Docker Image') {
      steps {
        container('docker') {
          sh "ls"
          sh "/kaniko/executor --context `pwd` --destination ${REPO}/app:1.0"
        }
      }
    }

    stage('Kubectl test') {
      steps {
        container('kubectl') {
            sh "kubectl config set-cluster deploy --server=${KUBEAPI} --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
            sh "kubectl config set-context deploy --cluster=deploy"
             sh """set +x
            kubectl config set-credentials user --token=\$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
            set -x"""
            sh "kubectl config set-context deploy --user=user"
            sh "kubectl config use-context deploy"
            sh "kubectl apply -f k8s/deployment.yaml"
        }
      }
    }

  }
}
