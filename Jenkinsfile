pipeline {
    agent any

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

        stage('Test step') {
            steps {
                echo 'Hello world!'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Starting build application ...'
                sh './mvnw clean install'
                echo 'Finished step \'Build\''
            }
        }
        
        // stage('Check Docker') {
        //     steps {
        //         echo 'Checking docker version ...'
        //         sh 'docker version'
        //     }
        // }
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
