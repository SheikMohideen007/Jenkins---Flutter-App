# Jenkins CI/CD Setup for Flutter App (GitHub + Webhooks)

📌 Objective

To set up a CI/CD pipeline using Jenkins for a Flutter application, such that:

Every push to the GitHub main branch

Automatically triggers a Jenkins pipeline

Runs:

```
flutter doctor

flutter pub get

flutter test

flutter build apk
```

🛠️ Tools & Technologies Used

Jenkins (Windows local installation)

GitHub (Source Code Repository)

ngrok (Expose local Jenkins to the internet)

Flutter SDK

GitHub Webhooks

Jenkinsfile (Pipeline as Code)

🧩 Step-by-Step Implementation
1️⃣ Jenkins Installation & Setup

Installed Jenkins on Windows

Jenkins accessible at:

`http://localhost:8080`

Initial admin setup completed

Required plugins installed:

Git

GitHub

GitHub API

Pipeline

Blue Ocean (optional)

2️⃣ Flutter Environment Verification

Verified Flutter setup using Jenkins workspace:

`flutter doctor`

✔ Flutter SDK detected
✔ Android SDK available
✔ Tests and builds run successfully via manual Jenkins build

3️⃣ Creating the Jenkins Pipeline Job

Created a Jenkins job named:

Todo List App

Job Type
Pipeline

Pipeline Definition
Pipeline script from SCM

SCM Configuration

SCM: Git

Repository URL:

`https://github.com/SheikMohideen007/Jenkins---Flutter-App.git`

Branches to build:

`*/main`

Script Path:

`Jenkinsfile`

Lightweight checkout: ❌ Disabled

4️⃣ Jenkinsfile (Pipeline as Code)

Added a Jenkinsfile at the root of the GitHub repository.

````pipeline {
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
            echo 'Pipeline completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}```


✔ File name case-sensitive
✔ Placed at repo root
✔ Committed and pushed to main

5️⃣ GitHub Webhook Configuration
Webhook URL

Used ngrok to expose local Jenkins:

```ngrok http 8080```


Generated URL example:

```https://coercible-winford-yawnful.ngrok-free.dev```

Webhook Settings in GitHub

Payload URL

```https://coercible-winford-yawnful.ngrok-free.dev/github-webhook/```


Content-Type: application/json

Events: Just the push event

Active: ✅ Enabled

6️⃣ Jenkins Build Trigger Configuration

In Jenkins job configuration:

✔ GitHub hook trigger for GITScm polling


❌ Poll SCM disabled
❌ Remote trigger disabled

7️⃣ Webhook Verification (System Logs)

Added a Jenkins System Log recorder:

Logger Name

org.jenkinsci.plugins.github.webhook


Log Level

ALL

````

Observed Log Output (Confirmed)
Received PushEvent from GitHub
Considering to poke Todo List App
Poked Todo List App

```

```
