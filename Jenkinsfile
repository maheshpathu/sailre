pipeline {
    agent any
    tools {
        maven 'maven'
        //jdk 'jdk'
        //ansible 'ansible'
        terraform 'terraform'
    }
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        ANSIBLE_HOST_KEY_CHECKING="False"
    }
    stages{
        stage('checkout') {
            steps {
                git branch: 'main', credentialsId: 'gitcredentials', url: 'https://github.com/maheshpathu/sailre.git'
            }            
        }
        stage('build') {
            steps{
                sh '''
                    mvn clean verify                    
                '''
            }
        }
        stage('setup environment') {
            steps {
                sh '''
                    terraform init
                    terraform apply --auto-approve
                    terraform output "public_ip" > hosts
                '''
            }
        }
        stage('deploy') {
            steps {
                ansiblePlaybook(playbook: 'sailor-playbook.yaml', credentialsId: 'aws_instance_ssh_key', inventory: 'hosts')
            }
        }
    }

}