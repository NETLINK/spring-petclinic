pipeline {
	agent {
		label 'master'
	}
	environment {
		PROJECT_ID = 'devops-311301'
		CLUSTER_NAME = 'CLUSTER-NAME'
		LOCATION = 'CLUSTER-LOCATION'
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
				sh 'mvn compile war:war'
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
		stage( 'Deploy to GKE' ) {
			steps {
				sh "sed -i 's/petclinic:latest/petclinic:${env.BUILD_ID}/g' deployment.yaml"
				step( [ $class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true ] )
			}
		}
	}
}
