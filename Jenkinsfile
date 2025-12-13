

pipeline{
    agent { label 'ec2-node' }

    environment {
        AWS_REGION = 'ap-south-1'
        AWS_ACCOUNT = '759210286431'
        ECR_REGISTRY = "${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        IMAGE_NAME = 'rushikesh0374/my-task-1-image'
        IMAGE_TAG = "release_${BUILD_NUMBER}"
    }

    stages {
        stage('Clone'){
            steps {
                git branch: "main", 
                url: "https://github.com/devrushikesh/my-task-1-project.git",
                credentialsId: "GITHUB_CRED"
            }
        }
        stage('Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
        stage('Login to ECR'){
            steps {
                sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
            }
        }

        stage('Push to ECR') {
            steps {
                sh "docker push ${ECR_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Clean Agent'){
            steps {
                sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true"
            }
        }

        // stage('Deploy') {
        //     steps {
        //         echo 'Deploying...'
        //     }
        // }
    }
}