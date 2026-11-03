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
                sh 'ls -la'
                sh 'test -f index.html'
                sh 'test -f style.css'
            }
        }

        stage('Test') {
            steps {
                echo 'Vérification des fichiers...'
                sh 'test -s index.html'
                sh 'test -s style.css'
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
