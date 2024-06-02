pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'devops-practices:latest'
        CONTAINER_NAME = 'devops-practices'
        PREV_CONTAINER_NAME = 'devops-practices-prev'
    }

    parameters {
        booleanParam(name: 'SKIP_TESTS', defaultValue: false, description: 'Skip run tests during Maven build')
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
                    def mvnCommand = './mvnw clean install'
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
                echo 'Stopping old container ...'
                    sh 'docker stop $CONTAINER_NAME || true'
                    sh 'docker rename $CONTAINER_NAME $PREV_CONTAINER_NAME || true'

                    echo 'Run new container ...'
                    sh 'docker run -d -p 8282:8080 --name $CONTAINER_NAME $DOCKER_IMAGE'

                    echo 'Removing old container ...'
                    sh 'docker rm $PREV_CONTAINER_NAME || true'

                    echo 'Removing old image ...'
                    sh 'docker rmi -f $(docker images -q --filter "dangling=true" --filter "reference=$DOCKER_IMAGE") || true'
                    sh 'docker rmi -f $(docker images -q --filter "reference=$DOCKER_IMAGE") || true'
            }
        }
    }
}
