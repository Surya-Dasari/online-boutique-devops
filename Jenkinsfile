pipeline {

agent any

environment {
NEXUS_URL = "http://localhost:8081/repository/ci-artifacts"
}

stages {


stage('Checkout Code') {
    steps {
        checkout scm
    }
}

stage('Prepare Scripts') {
    steps {
        sh 'chmod +x scripts/*.sh'
    }
}

stage('Debug Info') {
    steps {
        sh '''
        echo "Build Number: $BUILD_NUMBER"
        echo "Git Commit:"
        git rev-parse --short HEAD
        '''
    }
}

stage('Build Services') {

    parallel {

        stage('Build Go Services') {
            steps {
                sh './scripts/build-go.sh'
            }
        }

        stage('Build Node Services') {
            steps {
                sh './scripts/build-node.sh'
            }
        }

        stage('Build Python Services') {
            steps {
                sh './scripts/build-python.sh'
            }
        }

        stage('Build .NET Service') {
            steps {
                sh './scripts/build-dotnet.sh'
            }
        }

        stage('Build Java Service') {
            steps {
                sh './scripts/build-java.sh'
            }
        }

    }

}

stage('Validate Artifacts') {
    steps {
        sh 'python3 scripts/validate_artifacts.py'
    }
}

stage('Show Artifacts') {
    steps {
        sh '''
        echo "Artifacts generated:"
        find src -name "*${BUILD_NUMBER}*"
        '''
    }
}

stage('Upload Artifacts to Nexus') {
    steps {

        withCredentials([usernamePassword(
            credentialsId: 'nexus-creds-latest',
            usernameVariable: 'NEXUS_USER',
            passwordVariable: 'NEXUS_PASS'
        )]) {

            sh '''
            ./scripts/upload-to-nexus.sh
            '''
        }
    }
}

stage('Cleanup Old Nexus Artifacts') {
    steps {

        withCredentials([usernamePassword(
            credentialsId: 'nexus-creds-latest',
            usernameVariable: 'NEXUS_USER',
            passwordVariable: 'NEXUS_PASS'
        )]) {

            sh '''
            python3 scripts/cleanup-nexus.py
            '''
        }
    }
}
```

}

post {

```
always {
    echo "Cleaning Jenkins workspace"
    cleanWs()
}


}

}
