pipeline {
    agent any

    environment {
        FLUTTER_HOME = "C:/flutter"
        PATH = "${FLUTTER_HOME}/bin;${PATH}"
    }

    stages {

        stage('Flutter Doctor') {
            steps {
                bat 'flutter doctor'
            }
        }

        stage('Get Dependencies') {
            steps {
                bat 'flutter pub get'
            }
        }

        stage('Analyze Code') {
            steps {
                bat 'flutter analyze'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'flutter test'
            }
        }

        stage('Build APK') {
            steps {
                bat 'flutter build apk --debug'
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully.'
        }
        failure {
            echo '❌ Pipeline failed'
        }
    }
}
