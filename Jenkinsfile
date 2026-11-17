
pipeline {
    agent any

    options {
        timestamps()
    }

    environment {
        IMAGE = 'malekoueslati/monapp'
        TAG = "build-${BUILD_NUMBER}"
    }

    stages {

        // 1. Get source code from GitHub
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        // 2. Build Docker image
        stage('Docker Build') {
            steps {
                bat 'docker version'
                bat 'docker build -t %IMAGE%:%TAG% .'
            }
        }

        // 3. Test the application
        stage('Smoke Test') {
            steps {
                bat '''
                    docker rm -f monapp_test 2>nul

                    docker run -d --name monapp_test -p 8083:80 %IMAGE%:%TAG%

                    if errorlevel 1 exit /b 1

                    ping -n 4 127.0.0.1 > nul

                    curl -f http://localhost:8083

                    if errorlevel 1 (
                        docker logs monapp_test
                        docker rm -f monapp_test
                        exit /b 1
                    )

                    docker rm -f monapp_test
                '''
            }
        }

        // 4. Test Docker Hub credentials
        stage('Docker Login Test') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    bat '''
                        powershell -NoProfile -NonInteractive -Command "$env:DOCKER_PASS | docker login --username $env:DOCKER_USER --password-stdin"

                        if errorlevel 1 exit /b 1
                    '''
                }
            }
        }

        // 5. Push image to Docker Hub
        stage('Push (Docker Hub)') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    bat '''
                        powershell -NoProfile -NonInteractive -Command "$env:DOCKER_PASS | docker login --username $env:DOCKER_USER --password-stdin"

                        if errorlevel 1 exit /b 1

                        docker tag %IMAGE%:%TAG% %IMAGE%:latest

                        if errorlevel 1 exit /b 1

                        docker push %IMAGE%:%TAG%

                        if errorlevel 1 exit /b 1

                        docker push %IMAGE%:latest

                        if errorlevel 1 exit /b 1

                        docker logout
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Build + Smoke Test + Docker Hub Push SUCCESS!'
        }

        failure {
            echo 'Build / Test / Push FAILED!'
        }

        always {
            bat 'docker rm -f monapp_test 2>nul'
        }
    }
}
