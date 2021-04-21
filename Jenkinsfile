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

		stage( 'Build Docker Image' ) {
			steps {
				sh 'docker build -t netlinkie/petclinic:1.0.0 /home/ubuntu'
			}
		}
		stage( 'Push Docker Image' ) {
			steps {
				withCredentials( [ usernamePassword( credentialsId: 'DockerCredentials', passwordVariable: 'DockerPass', usernameVariable: 'DockerUser' ) ] ) {
					sh "docker login -u ${DockerUser} -p ${DockerPass}"
				}
				sh 'docker push -t netlinkie/petclinic:1.0.0'
			}
		}
	}
}
