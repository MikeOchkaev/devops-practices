pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'myapp:latest' // Имя и тег вашего Docker образа
    }
    
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/username/repository.git', branch: 'main'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Сборка Docker образа
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }
    }
}
