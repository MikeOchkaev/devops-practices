pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'myapp:latest' // Имя и тег вашего Docker образа
    }
    
    stages {
        stage('Checkout') {
            steps {
                git url: 'git@github.com:MikeOchkaev/devops-practices.git', branch: 'master'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvnw clean install'
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
