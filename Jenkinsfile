pipeline {
    agent any
    stages {
        stage('Update Base Image') {
            steps {
                sh 'docker pull ripl/lcm:1.4.0'
                sh 'docker pull ripl/lcm:1.4.0_trusty'
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build -t ripl/libbot2:latest -f Dockerfile ./'
                sh 'docker build -t ripl/libbot2:trusty -f Dockerfile_trusty ./'
            }
        }
        stage('Push Image') {
            steps {
                withDockerRegistry(credentialsId: 'DockerHub', url: 'https://index.docker.io/v1/') {
                    sh 'docker push ripl/libbot2:latest'
                    sh 'docker push ripl/libbot2:trusty'
                }
            }
        }
        stage('Post - Clean up') {
            steps {
                sh 'docker rmi ripl/lcm:1.4.0'
                sh 'docker rmi ripl/lcm:1.4.0_trusty'
                sh 'docker rmi ripl/libbot2:latest'
                sh 'docker rmi ripl/libbot2:trusty'
                cleanWs()
            }
        }
    }
}
