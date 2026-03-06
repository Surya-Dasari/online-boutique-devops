pipeline {
agent any


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

    stage('Build Microservices') {

        parallel {

            stage('Build Go Services') {
                steps {
                    sh './scripts/build-go.sh'
                }
            }

            stage('Build NodeJS Services') {
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

}


}
