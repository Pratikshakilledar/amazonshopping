pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '2', artifactNumToKeepStr: '2'))
    }
    agent any

    stages {
        stage('Code Compilation') {
            steps {
                echo 'Code compilation is starting'
                sh 'mvn clean compile'
                echo 'Code compilation is completed'
            }
        }

        stage('Code Package') {
            steps {
                echo 'Code packaging is starting'
                sh 'mvn clean package'
                echo 'Code packaging is completed'
            }
        }
        stage('Building & Tag Docker Image') {
                    steps {
                        echo 'Starting Building Docker Image'
                        sh 'docker build -t pratikshakilledar/amazon.com .'
                        sh 'docker build -t amazon.com-ms .'
                        echo 'Completed  Building Docker Image'
                    }
                }
                stage('Docker Image Scanning') {
                    steps {
                        echo 'Docker Image Scanning Started'
                        sh 'java -version'
                        echo 'Docker Image Scanning Started'
                    }
                }
                stage('Docker push to Docker Hub') {
                   steps {
                      script {
                         withCredentials([string(credentialsId: 'docker', variable: 'docker')]) {
                             sh 'docker login -u pratikshakilledar -p $docker docker.io'
                             echo "Push Docker Image to DockerHub: In Progress"
                             sh 'docker push pratikshakilledar/amazon.com:latest'
                             echo "Push Docker Image to DockerHub: Completed"
                         }
                      }
                    }
                }
                stage('Upload the docker Image to Nexus') {
                           steps {
                              script {
                                 withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                                 sh 'docker login http://3.88.10.250:8085/repository/nexusrep/ -u admin -p ${PASSWORD}'
                                 echo "Push Docker Image to Nexus : In Progress"
                                 sh 'docker tag pratikshakilledar/amazon.com 3.88.10.250:8085/nexusrep:latest'
                                 sh 'docker push 3.88.10.250:8085/nexusrep'
                                 echo "Push Docker Image to Nexus : Completed"
                                 }
                              }
                            }
                        }
    }
}
