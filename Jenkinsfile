pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'devops-practices:latest'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git url: 'git@github.com:MikeOchkaev/devops-practices.git', branch: 'master'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Starting build application ...'
                sh './mvnw clean install'
                echo 'Finished step \'Build\''
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Started building docker image ...'
                // Сборка Docker образа
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Run Docker Container') {
            steps {
                echo 'Run docker container ...'
                sh 'docker run -d -p 8181:8080 --name $DOCKER_IMAGE devops-practices'
            }
        }
    }
}
