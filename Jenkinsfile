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
		stage( 'Validate Project' ) {
			steps {
				sh 'mvn validate'
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
		stage( 'SonarQube Analysis' ) {
			agent any
			steps {
				withSonarQubeEnv( 'SonarQube' ) {
					sh 'mvn clean package sonar:sonar'
				}
			}
		}
		stage( 'Quality Gate' ) {
			steps {
				timeout( time: 1, unit: 'HOURS' ) {
					waitForQualityGate abortPipeline: true
				}
			}
		}
		stage( 'Deploy' ) {
			steps {
				sh 'java -jar /var/lib/jenkins/workspace/PetClinic-DeclarativePipeline/target/*.jar'
			}
		}
	}
}
