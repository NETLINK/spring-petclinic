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
                git branch: 'main',
                url: 'https://github.com/NETLINK/spring-petclinic.git'
            }
        }
        stage( 'Build' ) {
            steps {
                sh 'mvn compile'
            }
        }
        stage( 'Test' ) {
            steps {
                sh 'mvn test'
            }
        }
        stage( 'Package' ) {
            steps {
                sh 'mvn package'
            }
        }
        stage( 'Deploy' ) {
            steps {
                sh 'java -jar /var/lib/jenkins/workspace/PetClinic-DeclarativePipeline/target/*.jar'
            }
        }
    }
}
