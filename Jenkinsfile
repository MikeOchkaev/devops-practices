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
        
        stage('Build application') {
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
        
        stage('Build docker image') {
            steps {
                echo 'Started building docker image ...'
                // Сборка Docker образа
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Pushing docker image') {
            environment {
                registryCredential = 'my_docker_hub'
            }
            steps{
                script {
                    docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploying spring-app container to K8s') {
            steps {
                script {
                    kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
                }
            }
        }
    }
}
