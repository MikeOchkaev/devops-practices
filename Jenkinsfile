pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'devops-practices:latest'
        CONTAINER_NAME = 'devops-practices'
    }

    parameters {
        booleanParam(name: 'SKIP_TESTS', defaultValue: false, description: 'Skip tests during Maven build')
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
                script {
                    def mvnCommand = 'mvnw clean install'
                    if (params.SKIP_TESTS) {
                        mvnCommand += ' -DskipTests=true'
                    }
                    sh mvnCommand
                }
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
                sh 'docker stop $CONTAINER_NAME'
                sh 'docker rm $CONTAINER_NAME'
                sh 'docker run -d -p 8282:8080 --name $CONTAINER_NAME $DOCKER_IMAGE'
            }
        }
    }
}
