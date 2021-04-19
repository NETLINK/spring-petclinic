def sonarScanner(projectKey) {
    def scannerHome = tool 'sonarqube-scanner'
    withSonarQubeEnv( "sonarqube" ) {
        if ( fileExists( "sonar-project.properties" ) ) {
            sh "${scannerHome}/bin/sonar-scanner"
        }
        else {
            sh "${scannerHome}/bin/sonar-scanner -     Dsonar.projectKey=${projectKey} -Dsonar.java.binaries=build/classes -Dsonar.java.libraries=**/*.jar -Dsonar.projectVersion=${BUILD_NUMBER}"
        }
    }
    timeout(time: 10, unit: 'MINUTES') {
        waitForQualityGate abortPipeline: true
    }
}

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
		stage( 'SonarQube Code Scan' ) {
			steps {
				script {
					sonarScanner( 'category-service' )
				}
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
