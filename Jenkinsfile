pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1' // Thay bằng region ECR của bạn (ví dụ: us-west-2, ap-southeast-1)
        ECR_REGISTRY = '711652947591.dkr.ecr.us-east-1.aws.amazon.com' // Thay your-account-id và region
        REPO_NAME = 'aml-microservice'
        IMAGE_TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Tran-Anh-Tuan11/aml-microservice.git', branch: 'master'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %ECR_REGISTRY%/%REPO_NAME%:%IMAGE_TAG% .'
            }
        }
        stage('Push to ECR') {
            steps {
                withAWS(credentials: 'aws-credentials-id') {
                    bat 'aws ecr get-login-password --region %AWS_REGION% | docker login --username AWS --password-stdin %ECR_REGISTRY%'
                    bat 'docker push %ECR_REGISTRY%/%REPO_NAME%:%IMAGE_TAG%'
                }
            }
        }
        stage('Run Container') {
            steps {
                bat 'docker run -d -p 8080:8080 %ECR_REGISTRY%/%REPO_NAME%:%IMAGE_TAG%'
            }
        }
    }
}