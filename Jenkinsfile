pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/linus-secondary/coffee-house.git', branch: 'main'
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
