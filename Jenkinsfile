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
                sh "docker build -t $USERNAME/$DOCKER_IMAGE_NAME:$IMAGE_TAG_LATEST ."
            }
        }

        stage("Push docker image") {
            steps{
                echo "Started pushing docker image ..."
                script {
//                     docker.withRegistry( "https://www.docker.com", DOCKER_HUB_CREDENTIAL) {
//                                             sh "docker push $USERNAME/$DOCKER_IMAGE_NAME:$IMAGE_TAG_LATEST"
//                                             sh "docker rmi $USERNAME/$DOCKER_IMAGE_NAME:$IMAGE_TAG_LATEST"
//                     }
                    sh """
                        docker login -u o4ckaev@mail.ru -p Kalmik1994 https://registry.hub.docker.com
                        docker push $USERNAME/$DOCKER_IMAGE_NAME:$IMAGE_TAG_LATEST
                        docker rmi $USERNAME/$DOCKER_IMAGE_NAME:$IMAGE_TAG_LATEST
                    """
                }
            }
        }

        stage("Deploy app to K8s") {
            steps {
                echo "Started deploying app with k8s ..."
                script {
                    kubernetesDeploy (configs: 'deployment&service.yaml', kubeconfigId: 'minikube_config')
                }
            }
        }
    }
}
