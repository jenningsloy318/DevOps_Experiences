pipeline {
  agent {
    kubernetes {
        label 'nodejs'
        cloud 'kubernetes'
        defaultContainer 'jnlp'
        yaml """
apiVersion: v1
kind: Pod
metadata:
    namespace: jenkins2
    labels:
        name: jnlp
spec:
  nodeSelector:
    kubernetes.io/hostname: 'cnpvgl56588417'
  
  containers:
  - name: jnlp
    image: registry.gcsc.example.corp/jenkins/jnlp-slave:v3
    workingDir: /home/jenkins
    resources:
      limits:
        cpu: 2
        memory: 12Gi
    env:
    - name: JAVA_OPTS
      value: "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
    - name: JENKINS_URL
      value: http://jenkins-master.jenkins2:8080/
    - name: DOCKER_HOST
      value: tcp://10.58.137.243:2376
    - name: DOCKER_TLS_VERIFY
      value: 1
    securityContext:
      privileged: false
    tty: true
"""
}
}

stages {
        stage ('Start') {
            steps {
        // send build started notifications
                slackSend (color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
                
                }
        }
        stage('clone source code') {
            steps {
                git ( url: 'https://github.wdf.sap.corp/csc-devops/Owl.git',
                      branch: 'demo-may-2018'
                      )
            }
        }
            stage('build and push docker images') {
              steps {
                sh '  mkdir ~/.m2/'
                sh 'cp -f settings.xml ~/.m2/'
                sh 'cp -f settings-security.xml  ~/.m2/'
                sh 'cp -r docker ~/.docker'
                sh 'npm config set strict-ssl false'
                sh 'npm config set  http-proxy http://proxy.pvgl.sap.corp:8080'
                sh 'npm config set  https-proxy http://proxy.pvgl.sap.corp:8080'
                sh 'mvn clean install -X -Dmaven.test.skip=true  -Dhttp.proxyHost=proxy.pvgl.sap.corp -Dhttp.proxyPort=8080  -Dhttps.proxyHost=proxy.pvgl.sap.corp -Dhttps.proxyPort=8080 -Dhttp.nonProxyHosts=10.58.137.243,10.58.137.244'
              }
            }
            
        stage('deploy to kubernetes ') {
            steps {
                 sh 'bash deploytok8s.sh'
            }      
        }  
    }
post {
    success {
      slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")

    }

    failure {
      slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")

    }
  }
}

