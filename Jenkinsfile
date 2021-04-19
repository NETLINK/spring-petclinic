pipeline {
    agent {
        label 'master'
    }
    tools {
        maven 'Maven'
    }
    stages {
        stage( 'Checkout' ) {
            steps {
                sh 'echo "Checking out source code..."'
                git branch: 'main',
                url: 'https://github.com/NETLINK/spring-petclinic.git'
            }
        }
        stage( 'Build' ) {
            steps {
                echo 'Compiling...'
                sh 'mvn compile'
            }
        }
        stage( 'Test' ) {
            steps {
                echo 'Testing...'
                sh 'mvn test'
            }
        }
        stage( 'Package' ) {
            steps {
                echo 'Packaging...',
                sh 'mvn package'
            }
        }
        stage( 'Deploy' ) {
            steps {
                echo 'Deploying...',
                sh 'java -jar /var/lib/jenkins/workspace/PetClinic-DeclarativePipeline/target/*.jar'
            }
        }
    }
}
