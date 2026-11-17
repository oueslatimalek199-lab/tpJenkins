
pipeline {
    agent any

    options {
        timestamps()
    }

    environment {
        IMAGE = 'malekoueslati/monapp'
        TAG = "build-${env.BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker version'
                bat 'docker build -t %IMAGE%:%TAG% .'
            }
        }

        
stage('Smoke Test') {
    steps {
        bat '''
            docker rm -f monapp_test 2>nul || ver > nul

            docker run -d --name monapp_test -p 8083:80 %IMAGE%:%TAG%

            if errorlevel 1 exit /b 1

            ping -n 3 127.0.0.1 > nul

            curl -I http://localhost:8083 | findstr /C:"200 OK"

            if errorlevel 1 (
                docker logs monapp_test
                docker rm -f monapp_test
                exit /b 1
            )

            docker rm -f monapp_test
        '''
    }
}
stage('Docker Login Test') {
    steps {
        withCredentials([
            usernamePassword(
                credentialsId: 'dockerhub-creds',
                usernameVariable: 'USER',
                passwordVariable: 'PASS'
            )
        ]) {
            bat '''
            echo %PASS% | docker login -u %USER% --password-stdin
            if errorlevel 1 exit /b 1
            '''
        }
    }
}


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
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin

                        docker tag %IMAGE%:%TAG% %IMAGE%:latest

                        docker push %IMAGE%:%TAG%

                        docker push %IMAGE%:latest

                        docker logout
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Build + Test + Push OK'
        }

        failure {
            echo 'Build / Tests / Push KO'
        }
    }
}
