pipeline {
    agent {
        docker { image 'node:20.11.1-alpine3.19' }
    }

    environment {
        DOCKER_IMAGE = 'myapp:latest' // Имя и тег вашего Docker образа
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Started step \'Checkout\''
                git url: 'git@github.com:MikeOchkaev/devops-practices.git', branch: 'master'
                echo 'Finished step \'Checkout\'.'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Starting build application ...'
                sh './mvnw clean install'
                echo 'Finished step \'Build\''
            }
        }
        
        stage('Check Docker') {
            steps {
                echo 'Checking docker version ...'
                sh 'docker version'
            }
        }
        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             // Сборка Docker образа
        //             sh 'docker build -t $DOCKER_IMAGE .'
        //         }
        //     }
        // }
    }
}
