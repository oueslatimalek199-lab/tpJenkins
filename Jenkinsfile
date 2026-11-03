pipeline {
    agent any

    options {
        timestamps()
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Récupération du code source...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Préparation du projet...'
                bat 'dir'
                bat 'test -f index.html'
                bat 'test -f style.css'
            }
        }

        stage('Test') {
            steps {
                echo 'Vérification des fichiers...'
                bat 'if exist fichier.html (echo Fichier fichier.html existe) else (echo Fichier fichier.html introuvable & exit /b 1)'
                bat 'test -s fichier.css'
                echo 'Tous les fichiers sont présents.'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Simulation du déploiement...'
                echo 'Le projet est prêt à être déployé.'
            }
        }
    }

    post {
        success {
            echo 'Build OK'
        }
        failure {
            echo 'Build KO'
        }
    }
}
