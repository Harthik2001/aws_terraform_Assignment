# Terraform AWS VPC and EC2 Deployment

This repository contains Terraform scripts to create a custom VPC, generate SSH keys, and deploy two EC2 instances on AWS. One instance is deployed in a public subnet and runs NGINX, which is accessible from the internet, and the other instance is deployed in a private subnet.


## Overview

The Terraform configuration in this repository is divided into three main parts:
- **Networking**: Define the VPC and all of its components (subnets, route tables, internet gateway).
- **SSH-Key**: Dynamically create an SSH key pair for connecting to the VMs.
- **EC2**: Deploy one VM in the public subnet and another VM in the private subnet. The public VM runs NGINX and is accessible from the internet.



## Prerequisites

- Terraform >= 0.12
- AWS CLI configured with appropriate permissions
- Jenkins (optional, for automation)

  

- **networking**: Contains the Terraform configuration for the VPC, subnets, route tables, and internet gateway.
  - Path: `networking/`
  - Files:
    - `main.tf`: Defines the VPC, subnets, internet gateway, and route tables.
    - `outputs.tf`: Outputs the VPC and subnet IDs.
    - `variables.tf`: Defines input variables for the networking module.
- **ssh-key**: Contains the Terraform configuration to generate SSH key pairs.
  - Path: `ssh-key/`
  - Files:
    - `main.tf`: Creates an SSH key pair and saves it locally.
    - `outputs.tf`: Outputs the key file path.
    - `variables.tf`: Defines input variables for the SSH key module.
- **ec2**: Contains the Terraform configuration for deploying EC2 instances.
  - Path: `ec2/`
  - Files:
    - `main.tf`: Deploys EC2 instances in the public and private subnets and sets up a security group.
    - `outputs.tf`: Outputs the instance IDs and public IP address.
    - `variables.tf`: Defines input variables for the EC2 module.
- **main.tf**: The root module that integrates all the other modules.
- **outputs.tf**: Root module outputs.
- **variables.tf**: Root module input variables.
- **README.md**: This file, providing an explanation and usage instructions.

  ##Steps:

  **Step1 : Installation Of Terraform**

    sudo apt update

    sudo apt install -y gnupg software-properties-common

    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg -o /etc/apt/trusted.gpg.d/hashicorp.asc

    sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main" 

    sudo apt update

    sudo apt install terraform

    terraform --version
  
**Step2 : Installation of Jenkins**

    sudo apt update

    sudo apt install -y openjdk-11-jdk


    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

    sudo apt update

    sudo apt install -y jenkins

    sudo systemctl start jenkins

    sudo systemctl enable jenkins
    
    sudo systemctl status jenkins

**Get the initial admin password**

    sudo cat /var/lib/jenkins/secrets/initialAdminPassword

**Access Jenkins at**

     http://localhost:8080

**Step 4: Create a GitHub Repository**

**Step 5: Push The Entire Files to Git Hub**

**Step 6: In Jenkins Create a AWS Credentials of Access Key and Secret Access Key**

**Step 6: In Jenkins also Create a Github credential if you want to push the terraform .tfstate(optional)**



**Step7: Write the Jenkins File**
```
pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-terraform-credentials')  // Update credentials ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-terraform-credentials')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', credentialsId: 'Githubid', url: 'https://github.com/Harthik2001/aws_terraform_Assignment.git'
                sh 'ls -la'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                // -auto-approve flag added to bypass interactive prompt
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Commit and Push TFState') {
            steps {
                script {
                    // Ensure the state file exists before trying to add and commit
                    sh 'ls -la terraform.tfstate'

                    // Configure git user
                    sh 'git config --global user.email "harthiksa@sigmoidanalytics.com"'
                    sh 'git config --global user.name "Harthik2001"'

                    // Add the state file to git
                    sh 'git add terraform.tfstate'

                    // Commit the changes
                    sh 'git commit -m "Add updated terraform.tfstate"'

                    // Push the changes using credentials
                    withCredentials([usernamePassword(credentialsId: 'Githubid', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh 'git push https://$GIT_USERNAME:$GIT_PASSWORD@github.com/Harthik2001/aws_terraform_Assignment.git main'
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

```


**Step 8:Run The Pipeline**






**Snapshots:**



![script](https://github.com/user-attachments/assets/d55c49da-2d14-465e-ae2f-2073f94d1de8)






![step](https://github.com/user-attachments/assets/d3e9d601-ce1c-48d5-90d5-6ee1eb0f7cee)




![build](https://github.com/user-attachments/assets/c44655d1-b04f-4190-ab81-594d7ae5455b)







![Screenshot from 2024-11-21 15-26-54](https://github.com/user-attachments/assets/a2be1269-d285-451a-9286-13bdea8b933b)






![con](https://github.com/user-attachments/assets/38be9a40-9cc0-4e09-b5c2-e17f4544b2fc)






![nginx](https://github.com/user-attachments/assets/3495a358-a46b-4219-86f3-531e2b082fc0)











