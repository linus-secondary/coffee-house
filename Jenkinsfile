pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/linus-secondary/coffee-house.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'python3 --version'
                }
            }
        }
    }
}
