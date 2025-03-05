pipeline {
    agent any

    environment {
        IMAGE_NAME = "linusindevops/coffee-house"
        IMAGE_TAG = "latest"
        BUILD_TAG = "${env.BUILD_NUMBER}" 
        INFRA_REPO = "git@github.com:linus-secondary/coffee-house-CD.git"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/linus-secondary/coffee-house.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $IMAGE_NAME:$BUILD_TAG ."
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "docker push $IMAGE_NAME:$BUILD_TAG"
                }
            }
        }

        stage('Update Infra Repo') {
            steps {
                script {
                    sh """
                    rm -rf coffee-house-CD
                    git clone $INFRA_REPO
                    cd coffee-house-CD
                    git config user.name "Jenkins"
                    git config user.email "jenkins@job.com"            
                    sed -i "s|image: .*|image: ${IMAGE_NAME}:${BUILD_TAG}|" kubeManifest/deployment.yaml         
                    git add .
                    git commit -m "Update image to $BUILD_TAG"
                    git push origin main
                    """
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    sh "docker rmi $IMAGE_NAME:$BUILD_TAG"
                }
            }
        }
    }
}
