pipeline {
    agent any

    environment {
        USERNAME = "mikeochkaev"
        DOCKER_IMAGE_NAME = "devops-practices"
        IMAGE_TAG_LATEST = "latest"
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
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage("Pushing docker image") {
            steps{
                echo "Started pushing docker image ..."
                script {
                    docker.withRegistry( "docker.io", DOCKER_HUB_CREDENTIAL) {
                        sh "docker push $USERNAME/$DOCKER_IMAGE_NAME:$IMAGE_TAG_LATEST"
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
