
pipeline {
    agent any

    stages {

        stage('Checkout') {
    steps {
        echo 'Recuperation du projet GitHub'
        git url: 'https://github.com/oueslatimalek199-lab/tpJenkins.git',
            branch: 'main'
    }
}


        stage('Build') {
            steps {
                echo 'Verification des fichiers du projet'

                bat 'dir'

                bat 'if exist fichier.html (echo Fichier fichier.html existe) else (echo Fichier fichier.html introuvable & exit /b 1)'

                bat 'if exist fichier.css (echo Fichier fichier.css existe) else (echo Fichier fichier.css introuvable & exit /b 1)'
            }
        }

        stage('Test') {
            steps {
                echo 'Execution des tests'

                bat 'echo Test du fichier HTML'
                bat 'echo Test du fichier CSS'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploiement du projet'

                bat 'echo Projet deploye avec succes'
            }
        }
    }

    post {
        success {
            echo 'Pipeline execute avec succes !'
        }

        failure {
            echo 'Le pipeline a echoue.'
        }
    }
}


