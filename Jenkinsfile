pipeline {
    agent any

    environment {
        DOCKER_IMAGE = ""
        DOCKER_IMAGE_NAME = "devops-practices"
        DOCKER_HUB_CREDENTIAL = "my_docker_hub"
    }

    parameters {
        booleanParam(
            name: "SKIP_TESTS",
            defaultValue: false,
            description: "Skip run tests during Maven build"
        )
    }
    
    stages {
        stage("Checkout") {
            steps {
                git url: "git@github.com:MikeOchkaev/devops-practices.git", branch: "master"
            }
        }
        
        stage("Build application") {
            steps {
                echo "Starting build application ..."
                script {
                    def mvnCommand = "./mvnw clean install"
                    if (params.SKIP_TESTS) {
                        mvnCommand += " -DskipTests=true"
                    }
                    sh mvnCommand
                }
                echo "Finished step Build"
            }
        }
        
        stage("Build docker image") {
            steps {
                echo "Started building docker image ..."
                DOCKER_IMAGE = docker.build DOCKER_IMAGE_NAME
            }
        }

        stage("Pushing docker image") {
            steps{
                echo "Started pushing docker image ..."
                script {
                    docker.withRegistry( "https://registry.hub.docker.com", DOCKER_HUB_CREDENTIAL) {
                        DOCKER_IMAGE.push("latest")
                    }
                }
            }
        }

        stage("Deploying spring-app container to K8s") {
            steps {
                echo "Started deploying app with k8s ..."
                script {
                    kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
                }
            }
        }
    }
}
