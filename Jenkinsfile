pipeline {
    agent any
    
    environment {
        AWS_CREDENTIALS = credentials('aws-credentials')
        TERRAFORM_HOME = tool 'Terraform'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Harthik2001/aws_terraform_Assignment'
            }
        }
        
        stage('Terraform Init') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh "${TERRAFORM_HOME}/terraform init"
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh "${TERRAFORM_HOME}/terraform plan -out=tfplan"
                }
            }
        }
        
        stage('Terraform Apply') {
            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh "${TERRAFORM_HOME}/terraform apply tfplan"
                }
            }
        }
        
        stage('Verify Deployment') {
            steps {
                script {
                    def publicIp = sh(
                        script: "${TERRAFORM_HOME}/terraform output public_vm_ip",
                        returnStdout: true
                    ).trim()
                    
                    // Optional: Add additional verification steps
                    sh "curl http://${publicIp}"
                }
            }
        }
    }
    
    post {
        failure {
            sh "${TERRAFORM_HOME}/terraform destroy"
        }
        
        cleanup {
            sh "rm -f tfplan"
        }
    }
}