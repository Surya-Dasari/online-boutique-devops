pipeline {
agent any

tools {
    jdk 'jdk21'
}

stages {

    stage('Checkout Code') {
        steps {
            checkout scm
        }
    }

    stage('Build Microservices') {
        parallel {

            stage('Build Go Services') {
                steps {
                    sh '''
                    cd src/frontend
                    go build -o frontend .

                    cd ../productcatalogservice
                    go build -o productcatalogservice .

                    cd ../shippingservice
                    go build -o shippingservice .

                    cd ../checkoutservice
                    go build -o checkoutservice .
                    '''
                }
            }

            stage('Build Node Services') {
                steps {
                    sh '''
                    cd src/currencyservice
                    npm install

                    cd ../paymentservice
                    npm install
                    '''
                }
            }

            stage('Build Python Services') {
                steps {
                    sh '''
                    python3 -m venv venv
                    . venv/bin/activate

                    cd src/emailservice
                    pip install -r requirements.txt

                    cd ../recommendationservice
                    pip install -r requirements.txt

                    cd ../shoppingassistantservice
                    pip install -r requirements.txt

                    cd ../loadgenerator
                    pip install -r requirements.txt
                    '''
                }
            }

            stage('Build .NET Service') {
                steps {
                    sh '''
                    cd src/cartservice/src
                    dotnet restore
                    dotnet build
                    '''
                }
            }

            stage('Build Java Service') {
                steps {
                    sh '''
                    cd src/adservice
                    chmod +x gradlew
                    ./gradlew build -x verifyGoogleJavaFormat
                    '''
                }
            }

        }
    }
}

}
