pipeline {
    environment {
        registry = "https://372839978247.dkr.ecr.eu-west-1.amazonaws.com/udacity"
        registryCredential = 'ECR'
        dockerImage = '372839978247.dkr.ecr.eu-west-1.amazonaws.com/udacity:latest'
  }
     agent any
      stages {
         stage('Lint HTML')  { 
            steps  {
               sh 'tidy -q -e *.html'
                  sh 'hadolint --ignore DL3006 Dockerfile'
            }       
         } 
         stage('Security Scan') {
            steps { 
                  aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
            }
         }  
         stage('Clone repository') {
            steps { 
               git branch: "master", url: "https://github.com/AbdullahElsheikh2019/UdacityCapstoneProject.git", credentialsId: "jenkins-github"
            }
         }
         stage('Build image') {
            steps { 
               sh "docker build --build-arg APP_NAME=app -t 372839978247.dkr.ecr.eu-west-1.amazonaws.com/udacity:latest -f Dockerfile ."
            }   
         }
         stage('Push image') {
            steps{
                script {
                    docker.withRegistry( registry, registryCredential ) {
                        sh "docker push 372839978247.dkr.ecr.eu-west-1.amazonaws.com/udacity:latest"
                        }
                    }
               }
            }
         stage('set kubectl context') {
            steps{
               withAWS(region:'eu-west-1',credentials:'JenkinsAWS') {
                  sh '''
                     aws eks --region eu-west-1 update-kubeconfig --name udacity
                     kubectl config use-context arn:aws:eks:eu-west-1:372839978247:cluster/udacity
                     '''                  
                  }
               }
            }
         stage('Deploy') {
            steps{
               withAWS(region:'eu-west-1',credentials:'JenkinsAWS') {
                  sh 'kubectl apply -f ./K8Controller.yaml'
                   }
                }
            }                             
         }
      } 
  
