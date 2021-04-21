pipeline {
	agent {
		label 'master'
	}
	environment {
		PROJECT_ID = 'devops-311301'
		CLUSTER_NAME = 'cluster-1'
		LOCATION = 'europe-west1-c'
		CREDENTIALS_ID = 'GKE'
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
                
		stage( 'Validate' ) {
			steps {
				sh 'mvn validate'
			}
		}
		stage( 'Build' ) {
			steps {
				sh 'mvn clean install'
			}
		}
		stage( 'SonarQube Analysis' ) {
			agent any
			steps {
				withSonarQubeEnv( 'SonarQube' ) {
					sh 'mvn sonar:sonar'
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
		stage( 'Build Docker Image' ) {
			steps {
				sh "docker build -t netlinkie/petclinic:${env.BUILD_ID} ."
			}
		}
		stage( 'Push Docker Image' ) {
			steps {
				withCredentials( [ usernamePassword( credentialsId: 'DockerCredentials', passwordVariable: 'DockerPass', usernameVariable: 'DockerUser' ) ] ) {
					sh "docker login -u ${DockerUser} -p ${DockerPass}"
				}
				sh "docker push netlinkie/petclinic:${env.BUILD_ID}"
			}
		}

	}
}
