#!/usr/bin/env groovy

library identifier: 'jenkins-shared-library@main', retriever: modernSCM(
  [$class: 'GitSCMSource',
  remote: 'https://github.com/lpadgett23/jenkins-shared-library.git',
  credentialsId: 'github-credentials'
  ]
)

pipeline {   
  agent any
  tools {
    maven 'maven-3.9'
  }
  environment {
    IMAGE_NAME = 'lepcloud23/demo-app:java-maven-2.0-tf-1'
  }
  stages {
    stage("build app") {
      steps {
        script {
          echo 'building application jar...'
          buildJar()
        }
      }
    }
    stage("build image") {
      steps {
        script {
          echo 'building docker image...'
          buildImage(env.IMAGE_NAME)
          dockerLogin()
          dockerPush(env.IMAGE_NAME)
        }
      }
    }
    stage("deploy") {
      steps {
        script {
          echo 'deploying docker image to EC2...'
          
          def shellCmd = "bash ./server-cmds.sh ${IMAGE_NAME}"
          def ec2Instance = "ec2-user@3.89.248.161"

          sshagent(['ssh-credentials-ec2-1']) {
            sh 'ssh -v ec2-user@3.89.248.161 "echo connected"'
            sh "scp server-cmds.sh ${ec2Instance}:/home/ec2-user"
            sh "scp docker-compose.yaml ${ec2Instance}:/home/ec2-user"
            sh "ssh -o StrictHostKeyChecking=no ${ec2Instance} ${shellCmd}"
          }
        }
      }
    }               
  }
}

